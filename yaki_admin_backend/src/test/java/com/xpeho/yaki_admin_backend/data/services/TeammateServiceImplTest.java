package com.xpeho.yaki_admin_backend.data.services;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.xpeho.yaki_admin_backend.data.models.TeammateModel;
import com.xpeho.yaki_admin_backend.data.sources.TeammateJpaRepository;
import com.xpeho.yaki_admin_backend.domain.entities.TeammateDetailsEntity;
import com.xpeho.yaki_admin_backend.domain.entities.TeammateEntity;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.Arrays;
import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotEquals;
import static org.mockito.BDDMockito.given;
import static org.mockito.BDDMockito.willDoNothing;

@ExtendWith(MockitoExtension.class)
public class TeammateServiceImplTest {
    private final ObjectMapper objectMapper = new ObjectMapper();
    private TeammateModel teammate1;
    private TeammateModel teammate2;
    private TeammateEntity teammateE1;
    private TeammateEntity teammateE2;
    private List<Object[]> teammatesFromTeamOne;
    private List<TeammateDetailsEntity> teammatesEFromTeamOne;

    @InjectMocks
    private TeammateServiceImpl teammateService;
    @Mock
    private TeammateJpaRepository teammateJpaRepository;

    @BeforeEach
    void setup() {
        teammate1 = new TeammateModel(1, 5);
        teammate2 = new TeammateModel(1, 8);
        teammateE1 = new TeammateEntity(teammate1.getId(), 1, 5);
        teammateE2 = new TeammateEntity(teammate2.getId(), 1, 8);
        TeammateDetailsEntity teammateUserE1 = new TeammateDetailsEntity(1, 2, 5, "Albert", "Redmont", "albert.redmont@mail.com");
        TeammateDetailsEntity teammateUserE2 = new TeammateDetailsEntity(2, 2, 6, "Michel", "Bertrand", "michel.bertrand@mail.com");

        Object[] teammateUser1 = new Object[]{1, 2, 5, "Albert", "Redmont", "albert.redmont@mail.com"};
        Object[] teammateUser2 = new Object[]{2, 2, 6, "Michel", "Bertrand", "michel.bertrand@mail.com"};
        teammatesEFromTeamOne = Arrays.asList(teammateUserE1, teammateUserE2);
        teammatesFromTeamOne = Arrays.asList(teammateUser1, teammateUser2);
    }

    @Test
    void getTeammateByIdTest() throws Exception {
        //given
        given(teammateJpaRepository.findById(1)).willReturn(Optional.of(teammate1));

        //when
        TeammateEntity teammateDto = teammateService.getTeammate(1);
        //then
        String returnedResponse = objectMapper.writeValueAsString(teammateDto);
        String expectedResponse = objectMapper.writeValueAsString(teammateE1);
        assertEquals(returnedResponse,
                expectedResponse);
    }

    @Test
    void createTeammateTest() throws Exception {
        //given
        given(teammateJpaRepository.save(teammate1)).willReturn(teammate1);
        // when
        TeammateEntity savedTeammate = teammateService.createTeammate(teammateE1);
        // then - verify the output
        assertNotEquals(savedTeammate, (null));
    }

    //given
    @Test
    void saveTeammateTest() throws Exception {
        //given
        int idUsed = 3;
        TeammateModel replacedModel = new TeammateModel(idUsed, 235, 772);
        TeammateModel expectedModel = new TeammateModel(
                idUsed, teammate2.getTeamId(), teammate2.getUserId());
        given(teammateJpaRepository.save(expectedModel)).willReturn(expectedModel);
        given(teammateJpaRepository.findById(idUsed)).willReturn(Optional.of(replacedModel));

        //when
        TeammateEntity teammateDto = teammateService.saveOrUpdate(teammateE2, idUsed);

        //then
        String returnedResponse = objectMapper.writeValueAsString(teammateDto);
        TeammateEntity teammateE3 = new TeammateEntity(
                idUsed, expectedModel.getTeamId(), expectedModel.getUserId());
        String expectedResponse = objectMapper.writeValueAsString(teammateE3);
        assertEquals(returnedResponse,
                expectedResponse);
    }

    @Test
    void findAllByTeamTest() throws Exception {

        //given
      //  given(teammateJpaRepository.findAllByTeam(1)).willReturn(teammatesFromTeamOne);

        //when
        List<TeammateDetailsEntity> teammateDto = teammateService.findAllByTeam(1);

        //then
        //String returnedResponse = objectMapper.writeValueAsString(teammateDto);
      //  String expectedResponse = objectMapper.writeValueAsString(teammatesEFromTeamOne);
        //assertEquals(returnedResponse,
          //      expectedResponse);
    //}

    @Test
    void deleteByIdTest() throws Exception {

        //given
        int deletedId = 1;
        TeammateModel deletedModel = new TeammateModel(deletedId, 25, 86);
        willDoNothing().given(teammateJpaRepository).deleteById(deletedId);
        given(teammateJpaRepository.existsById(deletedId)).willReturn(Boolean.TRUE);
        given(teammateJpaRepository.findById(deletedId)).willReturn(Optional.of(deletedModel));

        //when
        TeammateEntity teamMateDeleted = teammateService.deleteById(deletedId);

        //then
        assertEquals(teamMateDeleted,
                new TeammateEntity(deletedModel.getId(),
                        deletedModel.getTeamId(), deletedModel.getUserId()));
    }
}
