package com.workmotion.app.member;


import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping(value = "/member/*")
public class MemberController {
	
	@Autowired
	private MemberService memberService;

	
	
	
	
	//�α׾ƿ�
	@GetMapping("logout")
	public String getlogout(HttpSession session,Model model)throws Exception {
		session.invalidate();
		return "member/login";
	}
	
    //�α���
	@GetMapping("login")
	public void getlogin()throws Exception{	
	}
	@PostMapping("login")
	public String getlogin(MemberDTO memberDTO,HttpSession session,Model model)throws Exception{
		memberDTO = memberService.getlogin(memberDTO);
		
		  if(memberDTO==null) {
			  model.addAttribute("msg","�����̵� �Ǵ� ��й�ȣ�� Ȯ���ϼ���");
			  return"member/login";
		  }else {
			  session.setAttribute("member",memberDTO);
			  model.addAttribute("page","home");
			  return "index";
		  }
		
	}
	//ȸ������
	@PostMapping("join")
	public String getjoin(MemberDTO memberDTO,Model model)throws Exception{

		int result =  memberService.getjoin(memberDTO);
		model.addAttribute("page","member/login");
		return "index";
	}
	//ȸ������
	@GetMapping("join")
	public String getjoin(Model model)throws Exception{
		model.addAttribute("page","member/join");
		return "member/join";
	}
	
	
	
	//����������
	@GetMapping("mypage")
	public String mypage(HttpSession session,Model model)throws Exception {
		MemberDTO m = (MemberDTO)session.getAttribute("member");
		model.addAttribute("page","member/mypage");
		return "index";
	}
	
	//���������� ��������
	@PostMapping("update")
	public String getupdate(MemberDTO memberDTO,HttpSession session,Model model) throws Exception { 
		memberService.detailMember(memberDTO);
		int result = memberService.updateMember(memberDTO);
		 model.addAttribute("page","home");
		 return "index";
	}
	
}
