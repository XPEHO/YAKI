package com.xpeho.yaki_admin_backend.data.services;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.xpeho.yaki_admin_backend.data.models.OwnerModel;
import com.xpeho.yaki_admin_backend.data.sources.OwnerJpaRepository;
import com.xpeho.yaki_admin_backend.domain.entities.OwnerEntity;
import jakarta.persistence.EntityNotFoundException;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.Arrays;
import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.BDDMockito.given;
import static org.mockito.BDDMockito.willDoNothing;

@ExtendWith(MockitoExtension.class)
class OwnerServiceImplTests {

    private final ObjectMapper objectMapper = new ObjectMapper();
    private OwnerModel owner1;
    private OwnerEntity ownerE1;
    @InjectMocks
    private OwnerServiceImpl ownerService;
    @Mock
    private OwnerJpaRepository ownerJpaRepository;

    @BeforeEach
    void setup() {
        owner1 = new OwnerModel(1);
        ownerE1 = new OwnerEntity(owner1.getId(), owner1.getUserId());
    }

    @Test
    void getOwnerByIdTest() throws Exception {
        //given
        given(ownerJpaRepository.findById(1)).willReturn(Optional.of(owner1));

        //when
        OwnerEntity ownerDto = ownerService.findById(1);
        //then
        String returnedResponse = objectMapper.writeValueAsString(ownerDto);
        String expectedResponse = objectMapper.writeValueAsString(ownerE1);
        assertEquals(returnedResponse,
                expectedResponse);
    }

    @Test
    void createOwnerTest() throws Exception {
        //given
        given(ownerJpaRepository.save(owner1)).willReturn(owner1);

        // when
        OwnerEntity savedOwner = ownerService.createOwner(ownerE1);

        // then - verify the output
        assertNotEquals(savedOwner, (null));
    }

    @Test
    void deleteByIdTest() throws Exception {
        //given
        int deletedId = 1;
        OwnerModel deletedModel = new OwnerModel(deletedId, 25);
        willDoNothing().given(ownerJpaRepository).deleteById(deletedId);
        given(ownerJpaRepository.findById(deletedId)).willReturn(Optional.of(deletedModel));

        //when
        OwnerEntity ownerMateDeleted = ownerService.deleteById(deletedId);

        //then
        assertEquals(ownerMateDeleted,
                new OwnerEntity(deletedModel.getId(),
                        deletedModel.getUserId()));
    }

    @Test
    void findAllTest() throws Exception {
        List<OwnerModel> customerModels = Arrays.asList(
                new OwnerModel(1, 1),
                new OwnerModel(2, 4),
                new OwnerModel(3, 10)
        );

        //when
        given(ownerJpaRepository.findAll()).willReturn(customerModels);
        List<OwnerEntity> ownerEntities = ownerService.findAll();

        //then
        assertEquals(3, ownerEntities.size());
        assertEquals(10, (int) ownerEntities.get(2).userId());
        assertEquals(2, (int) ownerEntities.get(1).id());


    }

    @Test
    void saveOrUpdateTest() {
        //given
        OwnerEntity ownerE2 = new OwnerEntity(34, 25);
        given(ownerJpaRepository.findById(1)).willReturn(Optional.of(owner1));
        given(ownerJpaRepository.save(any(OwnerModel.class))).willReturn(any(OwnerModel.class));
        //when
        OwnerEntity ownerResult = ownerService.saveOrUpdate(ownerE2, 1);
        //then
        assertEquals(ownerResult,
                new OwnerEntity(1,
                        ownerE2.userId()));
    }

    @Test
    void deleteByIdNotFoundTest() {
        // given
        int nonExistingId = 100;
        given(ownerJpaRepository.findById(nonExistingId)).willReturn(Optional.empty());

        // when
        assertThrows(EntityNotFoundException.class, () -> ownerService.deleteById(nonExistingId));
        // then

    }

    @Test
    void saveOrUpdateNonExistingIdTest() {
        // given
        int nonExistingId = 100;
        OwnerEntity entity = new OwnerEntity(nonExistingId, 30);
        given(ownerJpaRepository.findById(nonExistingId)).willReturn(Optional.empty());

        //then
        assertThrows(EntityNotFoundException.class, () -> ownerService.saveOrUpdate(entity, nonExistingId));
    }
}
