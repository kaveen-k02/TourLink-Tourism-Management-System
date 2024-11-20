package com.hm.hotel_management.rest;

import java.time.LocalDate;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping(path = "/auth")
public interface UserRegisterController {

	@PostMapping(path = "/signup")
	public ResponseEntity<String> signUp(@RequestBody(required = true) Map<String, String> requestMap);
	
	@DeleteMapping(path = "/{id}")
	public ResponseEntity<?> deleteUser(@PathVariable("id") String id);
	
	@GetMapping(path = "/{start}/{end}")
	public ResponseEntity<?> getAllPackageUsers(@PathVariable("start") String start, @PathVariable("end") String end);
	
	
}
