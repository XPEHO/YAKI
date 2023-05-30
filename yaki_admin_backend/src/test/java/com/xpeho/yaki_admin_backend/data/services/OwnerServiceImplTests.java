package com.xpeho.yaki_admin_backend.data.services;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.xpeho.yaki_admin_backend.data.models.OwnerModel;
import com.xpeho.yaki_admin_backend.data.sources.OwnerJpaRepository;
import com.xpeho.yaki_admin_backend.domain.entities.OwnerEntity;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.Optional;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotEquals;
import static org.mockito.BDDMockito.given;
import static org.mockito.BDDMockito.willDoNothing;

@ExtendWith(MockitoExtension.class)
public class OwnerServiceImplTests {

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
}
