package com.xpeho.yaki_admin_backend.data.services;

import com.xpeho.yaki_admin_backend.data.models.TeamModel;
import com.xpeho.yaki_admin_backend.data.sources.TeamJpaRepository;
import com.xpeho.yaki_admin_backend.domain.entities.TeamEntity;
import com.xpeho.yaki_admin_backend.domain.services.TeamService;
import jakarta.persistence.EntityNotFoundException;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class TeamServiceImpl implements TeamService {

    final TeamJpaRepository teamJpaRepository;

    public TeamServiceImpl(TeamJpaRepository teamJpaRepository) {
        this.teamJpaRepository = teamJpaRepository;
    }

    @Override
    public TeamEntity createTeam(TeamEntity teamEntity) {
        final TeamModel teamModel = new TeamModel(teamEntity.captainId(), teamEntity.teamName());
        teamJpaRepository.save(teamModel);
        //teamEntity.id could be null so we use autogenerate id
        return new TeamEntity(teamModel.getId(), teamEntity.captainId(), teamEntity.teamName());
    }

    @Override
    public TeamEntity getTeam(int id) {
        Optional<TeamModel> teamModelOpt = teamJpaRepository.findById(id);
        if (teamModelOpt.isEmpty()) {
            throw new EntityNotFoundException("The team with id " + id + " not found.");
        }
        TeamModel teamModel = teamModelOpt.get();
        return new TeamEntity(teamModel.getId(), teamModel.getCaptainId(), teamModel.getTeamName());
    }

    @Override
    public TeamEntity deleteById(int id) {
        final Optional<TeamModel> teamModelOpt = teamJpaRepository.findById(id);
        if (teamModelOpt.isPresent()) {
            TeamModel teamModel = teamModelOpt.get();
            teamJpaRepository.deleteById(id);
            return new TeamEntity(id, teamModel.getCaptainId(), teamModel.getTeamName());
        } else throw new EntityNotFoundException("The team with id " + id + " not found.");
    }

    @Override
    public TeamEntity saveOrUpdate(TeamEntity entity, int id) {
        Optional<TeamModel> teamModelOpt = teamJpaRepository.findById(id);
        if (teamModelOpt.isPresent()) {
            TeamModel teamModel = teamModelOpt.get();
            teamModel.setCaptainId(entity.captainId());
            teamModel.setTeamName(entity.teamName());
            teamJpaRepository.save(teamModel);
        } else {
            throw new EntityNotFoundException("Entity team with id " + id + " not found");
        }
        //id and entity.id() could be different
        return new TeamEntity(id, entity.captainId(), entity.teamName());
    }

    public List<TeamEntity> findAllByCaptain(int captainId) {
        List<TeamModel> results = teamJpaRepository.findAllByCaptain(captainId);
        List<TeamEntity> teamEntities = new ArrayList<>();
        for (TeamModel result : results) {
            TeamEntity teammEntity = new TeamEntity(result.getId(), result.getCaptainId(), result.getTeamName());
            teamEntities.add(teammEntity);
        }
        return teamEntities;
    }
}
