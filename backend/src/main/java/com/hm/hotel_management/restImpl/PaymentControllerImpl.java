package com.hm.hotel_management.restImpl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RestController;

import com.hm.hotel_management.dto.PaymentDTO;
import com.hm.hotel_management.rest.PaymentController;
import com.hm.hotel_management.service.paymentService;

@RestController
public class PaymentControllerImpl implements PaymentController{

	@Autowired
	paymentService paymentService;
	
	@Override
	public ResponseEntity<Object> add(List<Map<String, String>> data, String id) {
		return paymentService.add(data,id);
	}

}
