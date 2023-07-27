package com.xpeho.yaki_admin_backend.data.services

import com.xpeho.yaki_admin_backend.data.models.CaptainModel
import com.xpeho.yaki_admin_backend.data.models.UserModel
import com.xpeho.yaki_admin_backend.data.sources.CaptainJpaRepository
import com.xpeho.yaki_admin_backend.domain.entities.CaptainEntity
import com.xpeho.yaki_admin_backend.domain.entities.UserEntityWithID
import com.xpeho.yaki_admin_backend.data.models.TeamModel
import com.xpeho.yaki_admin_backend.domain.entities.TeamEntity
import com.xpeho.yaki_admin_backend.data.models.EntityLogModel
import com.xpeho.yaki_admin_backend.domain.services.CaptainService
import jakarta.persistence.EntityNotFoundException
import org.springframework.stereotype.Service
import java.util.*

@Service
class CaptainServiceImpl(private val captainJpaRepository: CaptainJpaRepository, private val entityLogService: EntityLogServiceImpl) : CaptainService {
    override fun getCaptains(): List<CaptainEntity> {
        return captainJpaRepository
                .findAll()
                .map { captainModel: CaptainModel ->
                    CaptainEntity(
                            captainModel.captainId,
                            captainModel.userId,
                            captainModel.customerId
                    )
                }
    }

    override fun createCaptain(captainEntity: CaptainEntity): CaptainEntity {
        val entityLogModel: EntityLogModel = entityLogService.createEntityLog()
        val captainModel: CaptainModel
        if (captainEntity.id == 0) {//in case we id is not specified
            captainModel = CaptainModel(captainEntity.userId, captainEntity.customerId,entityLogModel.id)
        }
        else{
            captainModel = CaptainModel(captainEntity.id,captainEntity.userId, captainEntity.customerId)
        }
        val savedCaptain = captainJpaRepository.save(captainModel)
        return CaptainEntity(savedCaptain.captainId, savedCaptain.userId, savedCaptain.customerId)
    }

    override fun getCaptainById(id: Int): CaptainEntity {
        val captainModelOptional = captainJpaRepository.findById(id)
        if (!captainModelOptional.isPresent) {
            throw EntityNotFoundException("The captain with id$id cannot be found.")
        }
        val captainModel = captainModelOptional.get()
        return CaptainEntity(captainModel.captainId, captainModel.userId, captainModel.customerId)
    }

    override fun deleteById(captainId: Int): CaptainEntity {
        val captainModelOpt = captainJpaRepository.findById(captainId)
        return if (captainModelOpt.isPresent) {
            captainJpaRepository.deleteById(captainId)
            val captainModel = captainModelOpt.get()
            CaptainEntity(
                    captainModel.captainId, captainModel.userId, captainModel.customerId
            )
        } else throw EntityNotFoundException("The captain with id$captainId cannot be found.")
    }

    override fun saveOrUpdate(entity: CaptainEntity, captainId: Int): CaptainEntity {
        val captainModelOpt = captainJpaRepository.findById(captainId)
        if (captainModelOpt.isPresent) {
            val captainModel = captainModelOpt.get()
            captainModel.userId = entity.userId
            captainModel.customerId = entity.customerId
            captainJpaRepository.save(captainModel)
        } else {
            throw EntityNotFoundException("Entity captain with id$captainId not found")
        }
        return CaptainEntity(captainId, entity.userId, entity.customerId)
    }

    override fun getAllCaptainByUserId(userId: Int): List<CaptainEntity> {
        return captainJpaRepository
                .findAllByUserId(userId)
                .filter { captainModel -> captainModel.isActif}
                .map { captainModel: CaptainModel ->
                    CaptainEntity(
                            captainModel.captainId,
                            captainModel.userId,
                            captainModel.customerId
                    )
                }

    }

    override fun getAllCaptainByCustomerId(customerId: Int): List<UserEntityWithID> {
        return captainJpaRepository
                .findAllCaptainByCustomerId(customerId)
                .map { userModel: UserModel ->
                    UserEntityWithID(
                            userModel.userId,
                            userModel.lastName,
                            userModel.firstName,
                            userModel.email
                    )
                }
    fun findAllById(id: MutableList<Int> ): MutableList<CaptainModel> {
        return captainJpaRepository.findAllById(id)
    }

    //disable the team but keep in log
    override fun disabled(captainId: Int): CaptainEntity? {
        val captainModelOpt: Optional<CaptainModel> = captainJpaRepository.findById(captainId)
        if (captainModelOpt.isEmpty) {
            throw EntityNotFoundException("The captain with id $captainId not found.")
        }
        val captainModel = captainModelOpt.get()
        entityLogService.disabledEntity(captainModel.entityLogId)
        captainModel.isActif = false
        captainJpaRepository.save(captainModel)
        return CaptainEntity(captainModel.captainId, captainModel.userId, captainModel.customerId)
    }
}
