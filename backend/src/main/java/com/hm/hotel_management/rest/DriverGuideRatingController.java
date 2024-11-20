package com.hm.hotel_management.rest;

import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hm.hotel_management.dto.DriverGuideRatingDTO;

@CrossOrigin(origins = "http://localhost:4200")
@RequestMapping(path = "/driver-guide-rating")
public interface DriverGuideRatingController {
	
	@GetMapping(path = "/{id}")
	public ResponseEntity<?> getAllDriverGuideRatingById(@PathVariable("id") String id);
	
	@GetMapping(path = "")
	public ResponseEntity<?> getAllDriverGuideRatingBySession();
	
	@PostMapping(path = "")
	public ResponseEntity<?> saveRate(@RequestBody DriverGuideRatingDTO driverGuideRatingDTO);
	
	@GetMapping(path = "/tourist/{id}")
	public ResponseEntity<?> getTouristFeedbakcs(@PathVariable("id") String id);
	
	@GetMapping(path = "/single/{id}")
	public ResponseEntity<?> getSingleFeedback(@PathVariable("id") String id);
	
	@DeleteMapping(path = "/{id}")
	public ResponseEntity<?> deleteFeedback(@PathVariable("id") String id);

}
