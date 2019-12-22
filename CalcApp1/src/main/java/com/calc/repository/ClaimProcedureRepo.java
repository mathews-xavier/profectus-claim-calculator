package com.calc.repository;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.calc.model.Sales;

@Repository
public interface ClaimProcedureRepo   extends CrudRepository<Sales, String>{

	@Query(value = "{call proc_tier_calc(:fromDate, :toDate)}", nativeQuery = true)
	String claimProcedure(@Param("fromDate") String frmDate,@Param("toDate") String toDate);
	
	
}
