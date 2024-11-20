package com.hm.hotel_management.serviceImpl;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.hm.hotel_management.dao.UserDao;
import com.hm.hotel_management.dao.UserPackageDao;
import com.hm.hotel_management.dao.paymentDao;
import com.hm.hotel_management.dto.PaymentDTO;
import com.hm.hotel_management.model.User;
import com.hm.hotel_management.model.UserAccount;
import com.hm.hotel_management.model.UserPackage;
import com.hm.hotel_management.model.paymnet;
import com.hm.hotel_management.service.paymentService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class paymentServiceImpl implements paymentService{

	
	@Autowired
	UserDao userDao;
	
	 @Autowired
	 UserPackageDao<?> userPackageDao;
	 
	 @Autowired
	 paymentDao<?> dao;

	@Override
	public ResponseEntity<Object> add(List<Map<String, String>> data, String id) {
		User ua = userDao.getUserByUserAccountId(id);
		
		 List<PaymentDTO> paymentDTOs = new ArrayList<>();
	        for (Map<String, String> x : data) {
	            PaymentDTO paymentDTO = new PaymentDTO();
	            paymentDTO.setPackageid(x.get("packageid"));
	            paymentDTOs.add(paymentDTO);
	        }
	        
	        for(PaymentDTO y: paymentDTOs) {
	        	paymnet up = new paymnet();
	        	UserPackage uapList = userPackageDao.getdata(ua.getId(),y.getPackageid());
	        	up.setUserPackageId(uapList.getId());
	        	up.setInsertDateTime(LocalDateTime.now());
	        	dao.save(up);
	        }
		
	        return ResponseEntity.ok("ok");
	}

}
