package com.workmotion.app.member;

import com.workmotion.app.company.CompanyDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class MemberDAO {

    @Autowired
    private SqlSession sqlSession;
    private final String NAMESPACE = "com.workmotion.app.member.MemberDAO.";

    public int setFileDelete(Avatar avatar) throws Exception {
        return sqlSession.delete(NAMESPACE + "setFileDelete", avatar);
    }

    public int setFileAdd(Avatar avatar) throws Exception {
        return sqlSession.insert(NAMESPACE + "setFileAdd", avatar);
    }

    public int setFileAdd(MemberDTO memberDTO) throws Exception {
        return sqlSession.insert(NAMESPACE + "setFileAddDefault", memberDTO);
    }

    public MemberDTO detailMember(MemberDTO memberDTO) throws Exception {
        System.out.println("memberDTO = " + memberDTO);
        return sqlSession.selectOne(NAMESPACE + "detailMember", memberDTO);
    }

    public int updateMember(MemberDTO memberDTO) throws Exception {
        return sqlSession.update(NAMESPACE + "updateMember", memberDTO);
    }

    public int createMember(MemberDTO memberDTO) throws Exception {
        return sqlSession.insert(NAMESPACE + "createMember", memberDTO);
    }

    public MemberDTO emailCheck(MemberDTO memberDTO) throws Exception {
        return sqlSession.selectOne(NAMESPACE + "emailCheck", memberDTO);
    }

    public CompanyDTO companyIdFind(CompanyDTO companyDTO) throws Exception {
        return sqlSession.selectOne(NAMESPACE + "companyIdFind", companyDTO);
    }

    public List<MemberDTO> getCompanyMember(MemberDTO memberDTO) throws Exception {
        return sqlSession.selectList(NAMESPACE + "getCompanyMember", memberDTO);
    }

    public MemberDTO findId(MemberDTO memberDTO) throws Exception {
        return sqlSession.selectOne(NAMESPACE + "findId", memberDTO);
    }

    public MemberDTO findPassWord(MemberDTO memberDTO) throws Exception {
        return sqlSession.selectOne(NAMESPACE + "findPassWord", memberDTO);
    }
}
