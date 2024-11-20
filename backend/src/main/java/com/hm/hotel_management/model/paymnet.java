package com.hm.hotel_management.model;

import java.sql.Date;
import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.GenericGenerator;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.format.annotation.DateTimeFormat;

import com.hm.model.GenericModel;

import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
@Table(name = "payment_log")
public class paymnet  extends GenericModel<paymnet>{

	@Id
	@GeneratedValue(generator = "uuid")
	@GenericGenerator(name = "uuid", strategy = "uuid2")
	@Column(name = "id", unique = true, nullable = false)
	private String id;
	
	@Column(name = "user_package_id")
	private String userPackageId;
	
	@Column(name = "insert_user_id")
	private String insertUserId;
	
	@Column(name = "update_user_id")
	private String updateUserId;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@Column(name = "insert_date")
	private LocalDateTime insertDateTime;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@Column(name = "update_date")
	private Date updateDateTime;
	
	@Column(name = "status")
	@ColumnDefault(value = "0")
	@Value(value = "0")
	private byte status;
	
	@Column(name = "sortOrder")
	@ColumnDefault(value = "0")
	@Value(value = "0")
	private Integer sortOrder;
	
}
