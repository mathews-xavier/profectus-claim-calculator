package com.calc.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.calc.exception.ResourceNotFoundException;
import com.calc.model.Purchase;
import com.calc.repository.ClaimProcedureRepo;
import com.calc.repository.PurchaseRepository;

@RestController
@RequestMapping("/api/v1")
public class PurchaseController {

	@Autowired
	PurchaseRepository purchaseRepo;
	
	@Autowired
	ClaimProcedureRepo claim;
	
	@GetMapping("/product/{id}")
    public ResponseEntity<Purchase> getProductById(@PathVariable(value = "id") String id) throws ResourceNotFoundException
    {
		Purchase purchase= purchaseRepo.findById(id)
				.orElseThrow(() -> new ResourceNotFoundException("Product not found for this id "+id ));
		return ResponseEntity.ok().body(purchase);
    }
	
	@GetMapping("/claim/fromDate/{frmDate}/toDate/{toDate}")
    public ResponseEntity<String> getClaim(@PathVariable(value = "frmDate") String frmDate,@PathVariable(value = "toDate") String toDate)
    {
		return ResponseEntity.ok().body(claim.claimProcedure(frmDate,toDate));
    }
}
