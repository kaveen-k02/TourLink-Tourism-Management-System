package com.hm.hotel_management.dao;

import com.hm.hotel_management.dto.PaymentDTO;
import com.hm.hotel_management.model.UserPackage;
import com.hm.hotel_management.model.paymnet;
import com.hm.repository.GenericRepository;

public interface paymentDao<T extends paymnet> extends GenericRepository<paymnet> {

	

}
