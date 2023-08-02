package com.xpeho.yaki_admin_backend.data.sources;

import com.xpeho.yaki_admin_backend.data.models.CaptainModel;
import com.xpeho.yaki_admin_backend.data.models.UserModel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface CaptainJpaRepository extends JpaRepository<CaptainModel, Integer> {
    List<CaptainModel> findAllByUserId(int id);

    List<CaptainModel> findAllByCustomerId(int customerId);

    @Query("SELECT DISTINCT user FROM UserModel user INNER JOIN CaptainModel cap ON cap.userId = user.userId INNER JOIN CustomerModel cust ON cust.id = cap.customerId WHERE cust.id = ?1")
    List<UserModel> findAllCaptainByCustomerId(int id);

}
