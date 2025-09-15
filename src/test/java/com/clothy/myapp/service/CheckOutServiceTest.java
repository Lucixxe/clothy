package com.clothy.myapp.service;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyLong;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import com.clothy.myapp.domain.*;
import com.clothy.myapp.repository.CartItemRepository;
import com.clothy.myapp.repository.CartRepository;
import com.clothy.myapp.repository.CustomerOrderRepository;
import com.clothy.myapp.repository.ProductRepository;
import com.clothy.myapp.service.dto.CartItemDTO;
import com.clothy.myapp.service.dto.CheckOutResultDTO;
import com.clothy.myapp.service.impl.CheckOutServiceImpl;
import com.clothy.myapp.web.rest.errors.CartEmptyException;
import com.clothy.myapp.web.rest.errors.OutOfStockException;
import java.math.BigDecimal;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.ThreadLocalRandom;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.atomic.AtomicInteger;
import org.aspectj.lang.annotation.Before;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.mockito.junit.MockitoJUnitRunner;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.util.ReflectionTestUtils;

@ExtendWith(MockitoExtension.class)
public class CheckOutServiceTest {

    @Mock
    private ProductRepository productRepository;

    @Mock
    private CartRepository cartRepository;

    @Mock
    private CustomerOrderService customerOrderService;

    @Mock
    private CartItemService cartItemService;

    @Mock
    private CartItemRepository cartItemRepository;

    @Mock
    private CustomerOrderRepository customerOrderRepository;

    @InjectMocks
    private CheckOutServiceImpl checkOutService;

    @Test
    public void testCreationCommande() {
        Product product = new Product();
        product.setId(1L);
        product.setSku(5);
        product.setPrice(BigDecimal.valueOf(150.000));

        Customer customer = new Customer();
        customer.setId(3L);

        Cart cart = new Cart();
        cart.setId(160L);
        cart.setIsCheckedOut(false);
        cart.setCustomer(customer);

        CartItem cartItem = new CartItem();
        cartItem.setProduct(product);
        cartItem.setCart(cart);
        cartItem.setQuantity(2);
        cartItem.setUnitPrice(BigDecimal.valueOf(10));
        cartItem.setLineTotal(BigDecimal.valueOf(20));

        CustomerOrder mockOrder = new CustomerOrder();
        mockOrder.setId(4L);
        mockOrder.setCustomer(customer);

        when(cartRepository.findById(160L)).thenReturn(Optional.of(cart));
        when(productRepository.findAndLockProductsByIdsOrderedById(Arrays.asList(product.getId()))).thenReturn(
            Optional.of(Arrays.asList(product)).orElse(Collections.emptyList())
        );
        when(customerOrderService.save(any(CustomerOrder.class))).thenReturn(mockOrder);
        when(customerOrderService.findOne(4L)).thenReturn(Optional.of(mockOrder));
        when(cartItemRepository.save(any(CartItem.class))).thenReturn(cartItem);
        when(cartItemRepository.getAllCartItemsForCartNotInOrder(160L)).thenReturn(Arrays.asList(cartItem));

        CheckOutResultDTO checkOutResultDTO = checkOutService.checkOut(cart.getId());

        assertNotNull(checkOutResultDTO);
        assertTrue(cart.getIsCheckedOut());
        assertEquals(product.getSku(), 3);
        assertEquals(cartItem.getCustomerOrder().getId(), mockOrder.getId());
    }

    @Test
    public void testOutOfStock() {
        Product product = new Product();
        product.setId(2L);
        product.setSku(1);
        product.setPrice(BigDecimal.valueOf(150.000));

        Customer customer = new Customer();
        customer.setId(3L);

        Cart cart = new Cart();
        cart.setId(101L);
        cart.setIsCheckedOut(false);
        cart.setCustomer(customer);

        CartItem cartItem = new CartItem();
        cartItem.setProduct(product);
        cartItem.setCart(cart);
        cartItem.setQuantity(2);
        cartItem.setUnitPrice(BigDecimal.valueOf(10));
        cartItem.setLineTotal(BigDecimal.valueOf(20));
        when(productRepository.findAndLockProductsByIdsOrderedById(Arrays.asList(product.getId()))).thenReturn(
            Optional.of(Arrays.asList(product)).orElse(Collections.emptyList())
        );
        when(cartItemRepository.getAllCartItemsForCartNotInOrder(101L)).thenReturn(Arrays.asList(cartItem));
        when(cartRepository.findById(anyLong())).thenReturn(Optional.of(cart));

        assertThrows(OutOfStockException.class, () -> checkOutService.checkOut(cart.getId()));
    }

    @Test
    public void testEmptyCart() {
        Cart cart = new Cart();
        cart.setId(101L);
        cart.setIsCheckedOut(false);

        CartItem cartItem = new CartItem();
        cartItem.setQuantity(2);
        cartItem.setUnitPrice(BigDecimal.valueOf(10));
        cartItem.setLineTotal(BigDecimal.valueOf(20));
        assertThrows(CartEmptyException.class, () -> checkOutService.checkOut(cart.getId()));
    }

    /*
    @Test
    public void testInit() throws InterruptedException {
        Long cartId1 = 100L;
        Long cartId2 = 200L;
        Long productId = 1L;

        // Create product with only 1 stock
        Product product = new Product();
        product.setId(productId);
        product.setSku(1); // Only 1 left!

        // Create carts and customers
        Customer customer1 = new Customer();
        customer1.setId(1L);
        Cart cart1 = new Cart();
        cart1.setId(cartId1);
        cart1.setCustomer(customer1);
        cart1.setIsCheckedOut(false);

        Customer customer2 = new Customer();
        customer2.setId(2L);
        Cart cart2 = new Cart();
        cart2.setId(cartId2);
        cart2.setCustomer(customer2);
        cart2.setIsCheckedOut(false);

        // Create cart items
        CartItem cartItem1 = new CartItem();
        cartItem1.setProduct(product);
        cartItem1.setCart(cart1);
        cartItem1.setQuantity(1);

        CartItem cartItem2 = new CartItem();
        cartItem2.setProduct(product);
        cartItem2.setCart(cart2);
        cartItem2.setQuantity(1);
    System.out.println("cartItemService is null: " + (cartItemService == null));
    System.out.println("checkOutService is null: " + (checkOutService == null));

    when(cartItemService.findAll()).thenReturn(Arrays.asList(cartItem1, cartItem2));
    // ... rest of your test
    }
    */

    @Test
    public void testConcurrentCheckout_OnlyOneSucceeds() throws InterruptedException {
        // Setup test data
        Long cartId1 = 100L;
        Long cartId2 = 200L;
        Long productId = 1L;

        // Create product with only 1 stock
        Product product = new Product();
        product.setId(productId);
        product.setSku(1); // Only 1 left!

        // Create carts and customers
        Customer customer1 = new Customer();
        customer1.setId(1L);

        Cart cart1 = new Cart();
        cart1.setId(cartId1);
        cart1.setCustomer(customer1);
        cart1.setIsCheckedOut(false);

        Customer customer2 = new Customer();
        customer2.setId(2L);

        Cart cart2 = new Cart();
        cart2.setId(cartId2);
        cart2.setCustomer(customer2);
        cart2.setIsCheckedOut(false);

        // Create cart items
        CartItem cartItem1 = new CartItem();
        cartItem1.setProduct(product);
        cartItem1.setCart(cart1);
        cartItem1.setQuantity(1);

        CartItem cartItem2 = new CartItem();
        cartItem2.setProduct(product);
        cartItem2.setCart(cart2);
        cartItem2.setQuantity(1);

        Map<Long, CartItem> savedCartItems = new ConcurrentHashMap<>();

        // Mock cartItemService.findAll() - returns all cart items

        // Mock cart repository - return appropriate cart for each ID
        when(cartRepository.findById(cartId1)).thenReturn(Optional.of(cart1));
        when(cartRepository.findById(cartId2)).thenReturn(Optional.of(cart2));
        when(cartItemRepository.getAllCartItemsForCartNotInOrder(100L)).thenReturn(Arrays.asList(cartItem1));
        when(cartItemRepository.getAllCartItemsForCartNotInOrder(200L)).thenReturn(Arrays.asList(cartItem2));
        when(cartItemRepository.save(any(CartItem.class))).thenAnswer(inv -> {
            CartItem item = inv.getArgument(0);

            if (item.getId() == null) {
                item.setId(ThreadLocalRandom.current().nextLong(1000, 2000));
            }

            savedCartItems.put(item.getId(), item);
            return item;
        });

        // CRITICAL: Mock the pessimistic locking repository call
        // This is where the race condition happens!
        AtomicInteger lockCallCount = new AtomicInteger(0);

        when(productRepository.findAndLockProductsByIdsOrderedById(Arrays.asList(productId))).thenAnswer(inv -> {
            int callNumber = lockCallCount.incrementAndGet();

            if (callNumber == 1) {
                // First thread gets the product with stock = 1
                Product lockedProduct = new Product();
                lockedProduct.setId(productId);
                lockedProduct.setSku(1);
                System.out.println("A thread has passed through here for success!");
                return Arrays.asList(lockedProduct);
            } else {
                // Second thread gets the product with stock = 0 (already decremented)
                Product lockedProduct = new Product();
                lockedProduct.setId(productId);
                lockedProduct.setSku(0); // No stock left!
                System.out.println("A thread has passed through here for failure!");

                return Arrays.asList(lockedProduct);
            }
        });

        Map<Long, CustomerOrder> savedOrders = new ConcurrentHashMap<>();
        // Mock product save
        when(productRepository.save(any(Product.class))).thenAnswer(inv -> inv.getArgument(0));

        when(customerOrderService.save(any(CustomerOrder.class))).thenAnswer(inv -> {
            CustomerOrder order = inv.getArgument(0);
            // mimic persistence again
            order.setId(ThreadLocalRandom.current().nextLong(1000, 2000));
            savedOrders.put(order.getId(), order);
            return order;
        });
        when(customerOrderService.findOne(anyLong())).thenAnswer(inv -> {
            Long id = inv.getArgument(0);
            return Optional.ofNullable(savedOrders.get(id));
        });

        // Concurrency test setup
        ExecutorService executor = Executors.newFixedThreadPool(2);
        CountDownLatch startLatch = new CountDownLatch(1);
        CountDownLatch doneLatch = new CountDownLatch(2);

        List<Exception> exceptions = Collections.synchronizedList(new ArrayList<>());
        List<CheckOutResultDTO> results = Collections.synchronizedList(new ArrayList<>());

        // Thread 1 - tries to checkout cart1
        executor.submit(() -> {
            try {
                startLatch.await();
                CheckOutResultDTO result = checkOutService.checkOut(cartId1);
                results.add(result);
            } catch (Exception e) {
                exceptions.add(e);
            } finally {
                doneLatch.countDown();
            }
        });

        // Thread 2 - tries to checkout cart2
        executor.submit(() -> {
            try {
                startLatch.await();
                CheckOutResultDTO result = checkOutService.checkOut(cartId2);
                results.add(result);
            } catch (Exception e) {
                exceptions.add(e);
            } finally {
                doneLatch.countDown();
            }
        });

        // Start both threads simultaneously
        startLatch.countDown();

        // Wait for completion
        doneLatch.await(5, TimeUnit.SECONDS);
        executor.shutdown();

        // Assertions
        assertEquals(1, results.size(), "Only one checkout should succeed");
        assertEquals(1, exceptions.size(), "One checkout should fail with OutOfStockException");
        assertTrue(exceptions.get(0) instanceof OutOfStockException, "Exception should be OutOfStockException");
        assertTrue(results.get(0).isSuccess(), "Successful checkout should return success=true");
    }
}
