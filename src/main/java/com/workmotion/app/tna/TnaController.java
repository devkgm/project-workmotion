package com.workmotion.app.tna;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.workmotion.app.member.MemberDTO;

@Controller
@RequestMapping(value = "/tna/*")
public class TnaController {
	@Autowired
	private TnaService tnaService;
	
	
	//���
	@GetMapping("in")
	public String getinTna(HttpSession session,Model model) throws Exception {
		MemberDTO m = (MemberDTO)session.getAttribute("member");
		int result = tnaService.getinTna(m);
		String msg = "��� ��� ����";
		if(result>0) {
			msg = "��� ��� ����";
		}
		
		model.addAttribute("page","/commons/result");
		model.addAttribute("msg",msg);
		model.addAttribute("path","/tna/my");
		return "index";
		
	}
	//���� ������
	@GetMapping("my")
	public String getmyTna (Model model)throws Exception {
		model.addAttribute("page","/tna/my");
		return "index";
	}
}
