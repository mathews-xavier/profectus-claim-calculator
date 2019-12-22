package com.calc.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.calc.model.Purchase;

@Repository
public interface PurchaseRepository extends JpaRepository<Purchase, String> {

}
