package com.workmotion.app.project.dao;

import com.workmotion.app.project.model.ProjectDTO;
import com.workmotion.app.project.model.TaskDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class TaskDAO {
    @Autowired
    private SqlSession sqlSession;
    private final String NAMESPACE = "com.workmotion.app.project.dao.TaskDAO.";

    public List<TaskDTO> getTaskList(ProjectDTO projectDTO) {
        return sqlSession.selectList(NAMESPACE + "getTaskList", projectDTO);
    }

    public int createTask(TaskDTO taskDTO) {
        return sqlSession.insert(NAMESPACE + "createTask", taskDTO);
    }

    public int updateTask(TaskDTO taskDTO) {
        return sqlSession.update(NAMESPACE + "updateTask", taskDTO);
    }

    public int deleteTask(TaskDTO taskDTO) {
        return sqlSession.delete(NAMESPACE + "deleteTask", taskDTO);
    }
}
