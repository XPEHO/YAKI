package com.xpeho.yaki_admin_backend.data.services

import com.xpeho.yaki_admin_backend.data.models.CaptainModel
import com.xpeho.yaki_admin_backend.data.sources.CaptainJpaRepository
import com.xpeho.yaki_admin_backend.domain.entities.CaptainEntity
import com.xpeho.yaki_admin_backend.domain.services.CaptainService
import jakarta.persistence.EntityNotFoundException
import org.springframework.stereotype.Service

@Service
class CaptainServiceImpl(private val captainJpaRepository: CaptainJpaRepository) : CaptainService {
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
        val captainModel = CaptainModel(captainEntity.userId, captainEntity.customerId)
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
}
