package com.xpeho.yaki_admin_backend.data.services;

import com.xpeho.yaki_admin_backend.data.models.CaptainModel;
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
    final CaptainServiceImpl captainService;
    final CaptainsTeamsServiceImpl captainsTeamsService;
    public TeamServiceImpl(TeamJpaRepository teamJpaRepository, CaptainServiceImpl captainService, CaptainsTeamsServiceImpl captainsTeamsService) {
        this.teamJpaRepository = teamJpaRepository;
        this.captainService = captainService;
        this.captainsTeamsService = captainsTeamsService;
    }

    @Override
    public TeamEntity createTeam(TeamEntity teamEntity) {

        List<CaptainModel> captainModels = captainService.findAllById(teamEntity.captainsId());
        final TeamModel teamModel = new TeamModel(captainModels, teamEntity.teamName(), teamEntity.customerId());
        teamJpaRepository.save(teamModel);
        //teamEntity.id could be null so we use autogenerate id
        List<Integer> captainsId = teamModel.getCaptains().stream()
                .map(CaptainModel::getCaptainId).toList();
        return new TeamEntity(teamModel.getId(), captainsId, teamModel.getTeamName(),teamModel.getCustomerId());

    }

    @Override
    public TeamEntity getTeam(int id) {
        Optional<TeamModel> teamModelOpt = teamJpaRepository.findById(id);
        if (teamModelOpt.isEmpty()) {
            throw new EntityNotFoundException("The team with id " + id + " not found.");
        }
        TeamModel teamModel = teamModelOpt.get();
        List<Integer> captainsId = teamModel.getCaptains().stream()
                .map(CaptainModel::getCaptainId).toList();
        return new TeamEntity(teamModel.getId(), captainsId, teamModel.getTeamName(),teamModel.getCustomerId());
    }

    @Override
    public TeamEntity deleteById(int id) {
        final Optional<TeamModel> teamModelOpt = teamJpaRepository.findById(id);
        if (teamModelOpt.isPresent()) {
            TeamModel teamModel = teamModelOpt.get();
            List<Integer> captainsId = teamModel.getCaptains().stream()
                    .map(captainModel -> captainModel.getCaptainId()).toList();
            TeamEntity returnedEntity = new TeamEntity(id, captainsId, teamModel.getTeamName(),teamModel.getCustomerId());
            teamJpaRepository.deleteById(id);
            return returnedEntity;
        } else throw new EntityNotFoundException("The team with id " + id + " not found.");
    }

    @Override
    public TeamEntity saveOrUpdate(TeamEntity entity, int id) {

        Optional<TeamModel> teamModelOpt = teamJpaRepository.findById(id);
        if (teamModelOpt.isPresent()) {
            TeamModel teamModel = teamModelOpt.get();
            //not mandatory to fill everything in the request (can be only to change the name)
            if(entity.captainsId() != null) {
                List<CaptainModel> captainModel = captainService.findAllById(entity.captainsId());
                teamModel.setCaptainId(captainModel);
            }
            if(entity.teamName() != null) {
                teamModel.setTeamName(entity.teamName());
            }
            if(entity.customerId() != null){
                teamModel.setCustomerId(entity.customerId());
            }
            teamJpaRepository.save(teamModel);
            List<Integer> captainsId = teamModel.getCaptains().stream()
                    .map(CaptainModel::getCaptainId).toList();
            return new TeamEntity(teamModel.getId(), captainsId, teamModel.getTeamName(),teamModel.getCustomerId());
        } else {
            throw new EntityNotFoundException("Entity team with id " + id + " not found");
        }
        //id and entity.id() could be different

    }

    public List<TeamEntity> findAllByCaptain(int captainId) {
        List<TeamModel> results = captainsTeamsService.findAllTeamsByCaptain(captainId);
        List<TeamEntity> teamEntities = new ArrayList<>();
        for (TeamModel result : results) {
            if(!result.isActif())continue; //if the Team has been deleted we don't return it
            List<Integer> captainsId = result.getCaptains().stream()
                    .map(CaptainModel::getCaptainId).toList();
            TeamEntity teammEntity = new TeamEntity(result.getId(), captainsId, result.getTeamName(),result.getCustomerId());
            teamEntities.add(teammEntity);
        }
        return teamEntities;
    }

    //disable the team but keep in log
    @Override
    public TeamEntity disabled(int teamId){
        Optional<TeamModel> teamModelOpt = teamJpaRepository.findById(teamId);
        if (teamModelOpt.isEmpty()) {
            throw new EntityNotFoundException("The team with id " + teamId + " not found.");
        }
        TeamModel teamModel = teamModelOpt.get();
        teamModel.setActif(false);
        teamJpaRepository.save(teamModel);
        List<Integer> captainsId = teamModel.getCaptains().stream()
                .map(CaptainModel::getCaptainId).toList();
        return new TeamEntity(teamModel.getId(), captainsId, teamModel.getTeamName(),teamModel.getCustomerId());
    }
}
