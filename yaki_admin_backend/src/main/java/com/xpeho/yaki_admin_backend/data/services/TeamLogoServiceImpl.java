package com.xpeho.yaki_admin_backend.data.services;

import com.xpeho.yaki_admin_backend.data.models.TeamLogoModel;
import com.xpeho.yaki_admin_backend.data.sources.TeamLogoRepository;
import com.xpeho.yaki_admin_backend.domain.entities.TeamLogoEntity;
import com.xpeho.yaki_admin_backend.domain.services.TeamLogoService;
import jakarta.persistence.EntityNotFoundException;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class TeamLogoServiceImpl implements TeamLogoService {
    final TeamLogoRepository teamLogoRepository;

    public TeamLogoServiceImpl(TeamLogoRepository teamLogoRepository) {
        this.teamLogoRepository = teamLogoRepository;
    }

    public TeamLogoEntity getTeamLogoByTeamId(int teamId) {
        Optional<TeamLogoModel> OptionalTeamLogoModel = teamLogoRepository.findOptionalByTeamLogoTeamId(teamId);

        if (OptionalTeamLogoModel.isPresent()) {
            TeamLogoModel teamLogoModel = OptionalTeamLogoModel.get();

            return teamLogoModel.toEntity();
        } else {
            throw new EntityNotFoundException("Team logo not found");
        }
    }

    @Override
    public TeamLogoEntity save(TeamLogoEntity teamLogoEntity) {
        final TeamLogoModel teamLogoModel = new TeamLogoModel(
                teamLogoEntity.teamId(),
                teamLogoEntity.teamLogoBlob()
        );
        TeamLogoModel createdTeamLogo = teamLogoRepository.save(teamLogoModel);

        return createdTeamLogo.toEntity();
    }

    public TeamLogoEntity createOrUpdateByTeamId(int teamId, byte[] teamLogoBlob) {
        Optional<TeamLogoModel> OptinalTeamLogoModel = teamLogoRepository.findOptionalByTeamLogoTeamId(teamId);

        if (OptinalTeamLogoModel.isPresent()) {

            TeamLogoModel teamLogoModelToUpdate = OptinalTeamLogoModel.get();
            teamLogoModelToUpdate.setTeamLogoBlob(teamLogoBlob);
            TeamLogoModel updated = teamLogoRepository.save(teamLogoModelToUpdate);
            return updated.toEntity();
        } else {
            return this.save(new TeamLogoEntity(teamId, teamLogoBlob));
        }
    }

    public TeamLogoEntity deleteByTeamId(int teamId) {
        Optional<TeamLogoModel> OptinalTeamLogoModel = teamLogoRepository.findOptionalByTeamLogoTeamId(teamId);

        if (OptinalTeamLogoModel.isPresent()) {
            TeamLogoModel teamLogoModelToDelete = OptinalTeamLogoModel.get();
            teamLogoRepository.delete(teamLogoModelToDelete);
            return teamLogoModelToDelete.toEntity();
        } else {
            throw new EntityNotFoundException("Team logo not found");
        }
    }
}
