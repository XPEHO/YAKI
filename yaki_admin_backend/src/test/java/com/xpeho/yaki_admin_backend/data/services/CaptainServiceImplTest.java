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
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.BDDMockito.given;
import static org.mockito.Mockito.*;

@SpringBootTest
class CaptainServiceImplTest {
    @Autowired
    private CaptainServiceImpl captainService;

    @MockBean
    private CaptainJpaRepository captainJpaRepository;

    @Test
    void getCaptainById() {
        //given
        CaptainModel captainEntity = new CaptainModel(1, 1, 2);

        //when
        when(captainJpaRepository.findById(1)).thenReturn(Optional.of(captainEntity));
        CaptainEntity captainDto = captainService.getCaptainById(1);

        //then
        assertEquals(1, (int) captainDto.id());
        assertEquals(1, captainDto.userId());
        assertEquals(2, captainDto.customerId());
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

    @Test
    void createCaptain() {
        //given
        CaptainEntity captainEntity = new CaptainEntity(1, 2, 3);
        when(captainJpaRepository.save(any())).thenReturn(new CaptainModel(1, 2, 3));

        //when
        CaptainEntity createCaptain = captainService.createCaptain(captainEntity);

        //then
        assertEquals(1, (int) createCaptain.id());
        assertEquals(captainEntity.userId(), createCaptain.userId());
        assertEquals(captainEntity.customerId(), createCaptain.customerId());
        verify(captainJpaRepository).save(any());
    }

    @Test
    void deleteById() {

        //given
        int captainId = 1;
        CaptainModel captainModel = new CaptainModel(captainId, 1, 2);


        when(captainJpaRepository.findById(captainId)).thenReturn(Optional.of(captainModel));
        doNothing().when(captainJpaRepository).deleteById(captainId);

        //when
        CaptainEntity result = captainService.deleteById(captainId);

        //then
        assertEquals(result,
                new CaptainEntity(captainModel.getCaptainId(),
                        captainModel.getUserId(), captainModel.getCustomerId()));
        verify(captainJpaRepository).deleteById(captainId);
    }

    @Test
    void saveOrUpdate() {

        // given
        int captainId = 1;
        CaptainEntity captainEntity = new CaptainEntity(2, 3, 3);
        CaptainModel captainModel = new CaptainModel(captainId, 4, 5);
        when(captainJpaRepository.findById(captainId)).thenReturn(Optional.of(captainModel));

        // when
        CaptainEntity savedCaptain = captainService.saveOrUpdate(captainEntity, captainId);

        // then
        verify(captainJpaRepository, times(1)).findById(captainId);
        verify(captainJpaRepository, times(1)).save(captainModel);
        assertEquals(captainId, savedCaptain.id());
        assertEquals(captainEntity.userId(), savedCaptain.userId());
        assertEquals(captainEntity.customerId(), savedCaptain.customerId());
    }
}
