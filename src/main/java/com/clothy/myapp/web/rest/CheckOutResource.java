package com.clothy.myapp.web.rest;

import com.clothy.myapp.service.CheckOutService;
import com.clothy.myapp.service.dto.CheckOutResultDTO;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/check_out_order")
public class CheckOutResource {

    private final CheckOutService checkOutService;

    public CheckOutResource(CheckOutService checkOutService) {
        this.checkOutService = checkOutService;
    }

    @PostMapping("/{cartId}")
    public ResponseEntity<CheckOutResultDTO> checkOut(@PathVariable Long cartId) {
        CheckOutResultDTO result = checkOutService.checkOut(cartId);
        System.out.println(result); // Affiche le résultat dans la console
        return ResponseEntity.ok(result);
    }
}
