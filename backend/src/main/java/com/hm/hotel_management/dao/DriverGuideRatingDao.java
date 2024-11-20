package com.hm.hotel_management.dao;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.hm.hotel_management.model.DriverGuideRating;
import com.hm.repository.GenericRepository;

public interface DriverGuideRatingDao<T extends DriverGuideRating> extends GenericRepository<DriverGuideRating>{
	
	@Query("select r from DriverGuideRating r where r.userId.id = :id and r.status = 0")
	List<DriverGuideRating> getAllDriverGuideRatingById(@Param("id")String id);
	
	@Query("select r from DriverGuideRating r where r.touristId.id = :id and r.status = 0")
	List<DriverGuideRating> getAllratingByTouristId(@Param("id")String id);

}
