package com.xpeho.yaki_admin_backend.data.sources;

import com.xpeho.yaki_admin_backend.data.dto.UserWithDetailsDto;
import com.xpeho.yaki_admin_backend.data.models.CaptainModel;
import com.xpeho.yaki_admin_backend.data.models.UserModel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface CaptainJpaRepository extends JpaRepository<CaptainModel, Integer> {
    List<CaptainModel> findAllByUserId(int id);

    List<CaptainModel> findAllByCustomerId(int customerId);

    @Query("SELECT new com.xpeho.yaki_admin_backend.data.dto.UserWithDetailsDto(u.userId, cap.captainId, u.lastName, u.firstName, u.email) FROM UserModel u INNER JOIN CaptainModel cap ON cap.userId = u.userId INNER JOIN CustomerModel cust ON cust.id = cap.customerId WHERE cust.id = ?1")
    List<UserWithDetailsDto> findAllCaptainByCustomerId(int id);
}
