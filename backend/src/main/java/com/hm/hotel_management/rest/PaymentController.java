package com.hm.hotel_management.rest;

import java.util.List;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.hm.hotel_management.dto.PaymentDTO;

@RestController
@RequestMapping("/payment")
public interface PaymentController {
	
	@PostMapping("/save/{id}")
	public ResponseEntity<Object> add(@RequestBody List<Map<String, String>> data, @PathVariable("id") String id);
    
}
