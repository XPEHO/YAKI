package com.xpeho.yaki_admin_backend.data.sources;

import com.xpeho.yaki_admin_backend.data.dto.UserWithDetailsDto;
import com.xpeho.yaki_admin_backend.data.models.CaptainModel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface CaptainJpaRepository extends JpaRepository<CaptainModel, Integer> {
    List<CaptainModel> findAllByUserId(int id);

    List<CaptainModel> findAllByCustomerId(int customerId);

    @Query("""
            SELECT new com.xpeho.yaki_admin_backend.data.dto.UserWithDetailsDto(u.userId, cap.captainId, cap.actifFlag, u.lastName, u.firstName, u.email, a.avatarReference, a.avatarBlob) 
            FROM UserModel u 
            INNER JOIN CaptainModel cap ON cap.userId = u.userId 
            INNER JOIN CustomerModel cust ON cust.id = cap.customerId 
            LEFT JOIN AvatarModel a on a.avatarId = u.userAvatarChoice 
            WHERE cust.id = ?1 AND cap.actifFlag = true
            """)
    List<UserWithDetailsDto> findAllCaptainByCustomerId(int id);
}
