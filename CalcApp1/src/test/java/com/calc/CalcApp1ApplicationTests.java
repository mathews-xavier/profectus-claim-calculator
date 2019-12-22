package com.calc;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.test.context.junit4.SpringRunner;

import com.calc.repository.ClaimProcedureRepo;
import com.calc.repository.PurchaseRepository;

@RunWith(SpringRunner.class)
@SpringBootTest
public class CalcApp1ApplicationTests {

	@MockBean
	private PurchaseRepository repository;
	
	
	@MockBean
	private ClaimProcedureRepo claim;
	
	@Test
	public void getProductTest()
	{
		assertEquals(repository.findById("A").get().getProductCode(),"A");
		
	}
	@Test
	public void getDateCalc()
	{
		assertNotNull(claim.claimProcedure("2019-12-18","2019-12-19"));
	}
	@Test
	public void contextLoads() {
	}

}
