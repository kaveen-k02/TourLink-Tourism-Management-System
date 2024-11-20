package com.hm.hotel_management.serviceImpl;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;

import org.hibernate.mapping.Set;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.hm.hotel_management.dao.UserDao;
import com.hm.hotel_management.dao.UserPackageDao;
import com.hm.hotel_management.model.HotelPackage;
import com.hm.hotel_management.model.User;
import com.hm.hotel_management.model.UserPackage;
import com.hm.hotel_management.service.CartService;
import com.hm.hotel_management.util.HotelMangUtils;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class CartServiceImpl implements CartService{
	
	  @Autowired
	  UserDao userDao;
	  @Autowired
	  UserPackageDao<?> userPackageDao;

	@Override
	public ResponseEntity<Object> add(Map<String, String> requestMap, String id) {
		try {
			User ua = userDao.findByEmailId(requestMap.get("userId"));
	        String extraParam = requestMap.get("extraParam");
	        String startDate = requestMap.get("startDate");
	        String endDate = requestMap.get("endDate");
	        UserPackage up = new UserPackage();
	        
	        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
	        LocalDate s = LocalDate.parse(startDate, formatter);
	        LocalDate e = LocalDate.parse(endDate, formatter);
	        
			up.setPackageid(id);
			up.setToursitId(ua.getId());
			up.setStartDate(s);
			up.setEndDate(e);
			if(extraParam.equals("1")) {
				up.setType("Hotel");
	        }else if (extraParam.equals("2")) {
	        	up.setType("Driver");
			}else if (extraParam.equals("3")) {
	        	up.setType("Guide");
			}
			
			userPackageDao.save(up);
			 return ResponseEntity.ok("ok");
		}catch (Exception e) {
			 e.printStackTrace();
			 return HotelMangUtils.getResponseEntity("Something went wrong 500", HttpStatus.INTERNAL_SERVER_ERROR);
		}

	}

	@Override
	public List<UserPackage> getAllCartDetail(String id) {
		User ua = userDao.getUserByUserAccountId(id);
		String userId = ua.getId();
		List<UserPackage> all = userPackageDao.getAll(userId);
		return all;
	}

	@Override
	public ResponseEntity<Object> delete(Map<String, String> requestMap, String id) {
		String pid =requestMap.get("id");
		User ua = userDao.getUserByUserAccountId(id);
		String userId = ua.getId();
		UserPackage data = userPackageDao.getdata(userId,pid);
		data.setStatus((byte) 1);
		userPackageDao.save(data);
		return ResponseEntity.status(200).body(HttpStatus.OK);
	}

	

}
