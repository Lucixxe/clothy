package com.clothy.myapp.service;

import com.clothy.myapp.service.dto.CheckOutResultDTO;

public interface CheckOutService {
    CheckOutResultDTO checkOut(Long cartId);
}
