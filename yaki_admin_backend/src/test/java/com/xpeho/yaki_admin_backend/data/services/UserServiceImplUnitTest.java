package com.xpeho.yaki_admin_backend.data.services;

import com.xpeho.yaki_admin_backend.data.models.UserModel;
import com.xpeho.yaki_admin_backend.data.sources.UserJpaRepository;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;

import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class UserServiceImplUnitTest {

    @InjectMocks
    private UserServiceImpl userService;

    @Mock
    private UserJpaRepository userJpaRepository;

    @Test
    @DisplayName("getUserPage should call getUserPage_should_call_findAllEnabledUsersByCustomerExcludingCaptains")
    void getUserPage_should_call_findAllEnabledUsersByCustomerExcludingCaptains() {
        // GIVEN
        UserModel user1 = new UserModel(1, "Beaumont", "Bertrand", "bertrand.beaumont@mail.com", "bertrand", "passwordHArd");
        Pageable pageable = PageRequest.of(0, 10);
        Integer customerId = 1;
        Boolean excludeCaptains = true;
        Integer excludeTeamId = null;

        when(userJpaRepository.findAllEnabledUsersByCustomerExcludingCaptains(any(), any())).thenReturn(new PageImpl<>(List.of(user1)));

        var expectedResult = new PageImpl<>(List.of(user1));


        // WHEN
        var result = userService.getUserPage(pageable, customerId, excludeCaptains, excludeTeamId);

        // THEN
        verify(userJpaRepository).findAllEnabledUsersByCustomerExcludingCaptains(any(), any());
        verify(userJpaRepository, never()).findAllEnabledUsersByCustomer(any(), any());
        verify(userJpaRepository, never()).findAllEnabledUsersByCustomerExcludingTeam(any(), any(), any());
        verify(userJpaRepository, never()).findAllEnabledUsers(any());

        assertEquals(expectedResult, result);

    }

    @Test
    @DisplayName("getUserPage should call findAllEnabledUsersByCustomerExcludingTeam")
    void getUserPage_should_call_findAllEnabledUsersByCustomerExcludingTeam() {
        // GIVEN
        UserModel user1 = new UserModel(1, "Beaumont", "Bertrand", "bertrand.beaumont@mail.com", "bertrand", "passwordHArd");
        Pageable pageable = PageRequest.of(0, 10);
        Integer customerId = 1;
        Boolean excludeCaptains = null;
        Integer excludeTeamId = 1;

        when(userJpaRepository.findAllEnabledUsersByCustomerExcludingTeam(any(), any(), any())).thenReturn(new PageImpl<>(List.of(user1)));

        var expectedResult = new PageImpl<>(List.of(user1));

        // WHEN
        var result = userService.getUserPage(pageable, customerId, excludeCaptains, excludeTeamId);

        // THEN
        verify(userJpaRepository, never()).findAllEnabledUsersByCustomerExcludingCaptains(any(), any());
        verify(userJpaRepository, never()).findAllEnabledUsersByCustomer(any(), any());
        verify(userJpaRepository).findAllEnabledUsersByCustomerExcludingTeam(any(), any(), any());
        verify(userJpaRepository, never()).findAllEnabledUsers(any());

        assertEquals(expectedResult, result);
    }

    @Test
    @DisplayName("getUserPage should call findAllEnabledUsersByCustomer")
    void getUserPage_should_call_findAllEnabledUsersByCustomer() {
        // GIVEN
        UserModel user1 = new UserModel(1, "Beaumont", "Bertrand", "bertrand.beaumont@mail.com", "bertrand", "passwordHArd");
        Pageable pageable = PageRequest.of(0, 10);
        Integer customerId = 1;
        Boolean excludeCaptains = null;
        Integer excludeTeamId = null;

        when(userJpaRepository.findAllEnabledUsersByCustomer(any(), any())).thenReturn(new PageImpl<>(List.of(user1)));

        var expectedResult = new PageImpl<>(List.of(user1));

        // WHEN
        var result = userService.getUserPage(pageable, customerId, excludeCaptains, excludeTeamId);

        // THEN
        verify(userJpaRepository, never()).findAllEnabledUsersByCustomerExcludingCaptains(any(), any());
        verify(userJpaRepository).findAllEnabledUsersByCustomer(any(), any());
        verify(userJpaRepository, never()).findAllEnabledUsersByCustomerExcludingTeam(any(), any(), any());
        verify(userJpaRepository, never()).findAllEnabledUsers(any());

        assertEquals(expectedResult, result);
    }

    @Test
    @DisplayName("getUserPage should call findAllEnabledUsers")
    void getUserPage_should_call_findAllEnabledUsers() {
        // GIVEN
        UserModel user1 = new UserModel(1, "Beaumont", "Bertrand", "bertrand.beaumont@mail.com", "bertrand", "passwordHArd");
        Pageable pageable = PageRequest.of(0, 10);
        Integer customerId = null;
        Boolean excludeCaptains = null;
        Integer excludeTeamId = null;

        when(userJpaRepository.findAllEnabledUsers(any())).thenReturn(new PageImpl<>(List.of(user1)));

        var expectedResult = new PageImpl<>(List.of(user1));

        // WHEN
        var result = userService.getUserPage(pageable, customerId, excludeCaptains, excludeTeamId);

        // THEN
        verify(userJpaRepository, never()).findAllEnabledUsersByCustomerExcludingCaptains(any(), any());
        verify(userJpaRepository, never()).findAllEnabledUsersByCustomer(any(), any());
        verify(userJpaRepository, never()).findAllEnabledUsersByCustomerExcludingTeam(any(), any(), any());
        verify(userJpaRepository).findAllEnabledUsers(any());

        assertEquals(expectedResult, result);
    }


}
