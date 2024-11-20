package com.hm.hotel_management.dao;

import java.time.LocalDate;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.hm.hotel_management.model.User;
import com.hm.hotel_management.model.UserPackage;
import com.hm.repository.GenericRepository;

public interface UserPackageDao<T extends UserPackage> extends GenericRepository<UserPackage> {

	@Query("select u from UserPackage u where u.toursitId = :id and u.status=0")
	List<UserPackage> getAll(@Param("id") String id);

	@Query("select u from UserPackage u where u.toursitId = :id and u.packageid=:uid")
	UserPackage getdata(@Param("id")String id, @Param("uid")String pid);

	@Query("SELECT u FROM UserPackage u WHERE (u.startDate <= :endDate AND u.endDate >= :start) AND u.status = 0")
	List<UserPackage> getAllPackage(@Param("start") LocalDate start, @Param("endDate") LocalDate endDate);




	
}
