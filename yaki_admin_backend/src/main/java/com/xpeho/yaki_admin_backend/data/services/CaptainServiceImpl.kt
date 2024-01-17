package com.xpeho.yaki_admin_backend.data.services

import com.xpeho.yaki_admin_backend.data.dto.UserWithDetailsDto
import com.xpeho.yaki_admin_backend.data.models.CaptainModel
import com.xpeho.yaki_admin_backend.data.models.EntityLogModel
import com.xpeho.yaki_admin_backend.data.sources.CaptainJpaRepository
import com.xpeho.yaki_admin_backend.domain.entities.CaptainEntity
import com.xpeho.yaki_admin_backend.domain.entities.UserEntityWithID
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
        if (captainEntity.id == 0) {//in case we did is not specified
            captainModel = CaptainModel(captainEntity.userId, captainEntity.customerId, entityLogModel.id)
        } else {
            captainModel = CaptainModel(captainEntity.id, captainEntity.userId, captainEntity.customerId, entityLogModel.id)
        }
        val savedCaptain = captainJpaRepository.save(captainModel)
        return CaptainEntity(savedCaptain.captainId, savedCaptain.userId, savedCaptain.customerId)
    }

    override fun getCaptainById(id: Int): CaptainEntity {
        val captainModelOptional = captainJpaRepository.findById(id)
        if (!captainModelOptional.isPresent) {
            throw EntityNotFoundException("The captain with id $id cannot be found.")
        }
        val captainModel = captainModelOptional.get()
        return CaptainEntity(captainModel.captainId, captainModel.userId, captainModel.customerId)
    }

    override fun deleteById(id: Int): CaptainEntity {
        val captainModelOpt = captainJpaRepository.findById(id)
        return if (captainModelOpt.isPresent) {
            captainJpaRepository.deleteById(id)
            val captainModel = captainModelOpt.get()
            CaptainEntity(
                    captainModel.captainId, captainModel.userId, captainModel.customerId
            )
        } else throw EntityNotFoundException("The captain with id $id cannot be found.")
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

    override fun getAllCaptainsIdByUserId(userId: Int): List<Int> {
        return captainJpaRepository
                .findAllByUserId(userId)
                .filter { captainModel -> captainModel.actifFlag }
                .map { captainModel: CaptainModel ->
                    captainModel.captainId
                }

    }


    override fun getAllCaptainByCustomerId(customerId: Int): List<UserEntityWithID> {
        println("captain service impl " + captainJpaRepository.findAllByCustomerId(customerId))
        return captainJpaRepository
                .findAllCaptainByCustomerId(customerId)
                .map { userWithDetails: UserWithDetailsDto ->
                    UserEntityWithID(
                            userWithDetails.id,
                            userWithDetails.captainId,
                            null,
                            userWithDetails.lastName,
                            userWithDetails.firstName,
                            userWithDetails.email,
                            userWithDetails.avatarReference,
                            userWithDetails.avatarBlob,
                    )
                }
    }


    fun findAllById(id: MutableList<Int>): MutableList<CaptainModel> {
        return captainJpaRepository.findAllById(id)
    }

    //disable the captain but keep in log
    override fun disabled(captainId: Int): CaptainEntity {
        val captainModelOpt: Optional<CaptainModel> = captainJpaRepository.findById(captainId)
        if (captainModelOpt.isEmpty) {
            throw EntityNotFoundException("The captain with id $captainId not found.")
        }
        val captainModel = captainModelOpt.get()
        entityLogService.disabledEntity(captainModel.entityLogId)
        captainModel.actifFlag = false
        captainJpaRepository.save(captainModel)
        return CaptainEntity(captainModel.captainId, captainModel.userId, captainModel.customerId)
    }
}
