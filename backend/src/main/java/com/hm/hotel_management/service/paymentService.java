package com.hm.hotel_management.service;

import java.util.List;
import java.util.Map;

import org.springframework.http.ResponseEntity;

public interface paymentService {

	ResponseEntity<Object> add(List<Map<String, String>> data, String id);

}
