package com.workmotion.app.member;





import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;



@Service
public class MemberService {

	@Autowired
	private MemberDAO memberDAO;


	//�α���
	public MemberDTO getlogin(MemberDTO memberDTO) throws Exception {
		MemberDTO m = memberDAO.detailMember(memberDTO);
		if(m!=null) {
			if(m.getPassword().equals(memberDTO.getPassword())) {
				  //�̸����� �°� ��й�ȣ�� �´�
				return memberDTO;
				}else {
				  //�̸����� �°� ��й�ȣ�� �ٸ���
				   m = null;
				} 
			}else {
				m=null;	
			}
			return m;
		
	}
	
	public int updateMember(MemberDTO memberDTO) throws Exception {
		return	memberDAO.updateMember(memberDTO);
	}
	
	public MemberDTO detailMember(MemberDTO memberDTO) throws Exception {
		return memberDAO.detailMember(memberDTO);
	}

	public int getjoin(MemberDTO memberDTO) throws Exception {
		return memberDAO.createMember(memberDTO);
	}
}
