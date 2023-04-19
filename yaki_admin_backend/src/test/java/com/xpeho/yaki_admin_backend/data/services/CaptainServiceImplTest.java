package com.xpeho.yaki_admin_backend.data.services;

import com.xpeho.yaki_admin_backend.data.models.CaptainModel;
import com.xpeho.yaki_admin_backend.data.models.CustomerModel;
import com.xpeho.yaki_admin_backend.data.sources.CaptainJpaRepository;
import com.xpeho.yaki_admin_backend.domain.entities.CaptainEntity;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;

import java.util.Arrays;
import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.BDDMockito.given;
import static org.mockito.Mockito.when;

@SpringBootTest
public class CaptainServiceImplTest {
    @Autowired
    private CaptainServiceImpl captainService;

    @MockBean
    private CaptainJpaRepository captainJpaRepository;

    @Test
    void getCaptainById() {
        //given
        CustomerModel customerModel = new CustomerModel("Géo trouve tout", 1, 1);
        CaptainModel captainEntity = new CaptainModel(1, 1, 2);

        //when
        when(captainJpaRepository.findById(1)).thenReturn(Optional.of(captainEntity));
        CaptainEntity captainDto = captainService.getCaptainById(1);

        //then
        assertEquals(1, (int) captainDto.id());
        assertEquals(captainDto.userId(), 1);
        assertEquals(captainDto.customerId(), 2);

    }

    @Test
    void getCaptains() {
        //given
        CustomerModel customerModel = new CustomerModel("Géo trouve tout", 1, 1);
        List<CaptainModel> captainModels = Arrays.asList(
                new CaptainModel(1, 1, 2),
                new CaptainModel(2, 1, 2),
                new CaptainModel(3, 2, 2)
        );

        //when
        given(captainJpaRepository.findAll()).willReturn(captainModels);
        List<CaptainEntity> captainEntities = captainService.getCaptains();

        //then
        assertEquals(3, captainEntities.size());
        assertEquals(1, (int) captainEntities.get(0).id());
        assertEquals(2, (int) captainEntities.get(2).userId());
        assertEquals(2, (int) captainEntities.get(1).customerId());

    }


}

