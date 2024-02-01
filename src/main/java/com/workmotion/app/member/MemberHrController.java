package com.workmotion.app.member;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.workmotion.app.util.Pager;

@Controller
@RequestMapping("/hr/*")
public class MemberHrController {

	@Autowired
	private MemberService memberService;
	
	@GetMapping("list")
	public String getMemberList(Pager pager,MemberDTO memberDTO,Model model) throws Exception {
		List<MemberDTO>ar = memberService.getMemberList(pager,memberDTO);
		model.addAttribute("list",ar);
		model.addAttribute("pager",pager);
		return "/";
	}
	@GetMapping("detail")
	public String getMemberDetail (MemberDTO memberDTO,Model model) throws Exception{
		int result =  memberService.getMemberDetail(memberDTO);
		model.addAttribute("result",result);
		return "/";
	}
	@PostMapping("update")
	public String updateMember (MemberDTO memberDTO,Model model) throws Exception{
		int result =  memberService.updateMember(memberDTO);
		return "/";
	}
	@PostMapping("delete")
	public String deleteMember(MemberDTO memberDTO,Model model) throws Exception {
		int result =  memberService.deleteMember(memberDTO);
		return "/";
	}
//	@PostMapping("create")
//	public String createMember(MemberDTO memberDTO,Model model)throws Exception{
//		int result =  memberService.createMember(memberDTO);
//		model.addAttribute("result",result);
//		model.addAttribute("page","hr/create");
//		return "index";
//	}
	@GetMapping("create")
	public String createMember(MemberDTO memberDTO,Model model)throws Exception{
//		int result =  memberService.createMember(memberDTO);
//		model.addAttribute("result",result);
		model.addAttribute("page","hr/create");
		return "index";
	}
}