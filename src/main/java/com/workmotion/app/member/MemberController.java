package com.workmotion.app.member;


import com.workmotion.app.company.CompanyDTO;
import com.workmotion.app.tosspayment.TossPaymentDTO;
import com.workmotion.app.tosspayment.TossPaymentService;
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.List;
import java.util.Random;
import java.util.StringTokenizer;


@Controller
@RequestMapping(value = "/member/*")
public class MemberController {


    @Autowired
    private MemberService memberService;
    @Autowired
    private TossPaymentService tossPaymentService;
    @Autowired
    private JavaMailSender mailSenderNaver;


    @ResponseBody
    @PostMapping("findPassWord")
    public int findPassWord(MemberDTO memberDTO, Model model) throws Exception {
        int result = 0;
        if (memberDTO != null) {
            MemberDTO m = memberService.findPassWord(memberDTO);
            if (m != null) {   // 존재하는 아이디면
                Random r = new Random();
                int num = r.nextInt(999999);  //랜덤 난수 6자리
                StringBuilder sb = new StringBuilder();
                String email = m.getEmail();
                String social = email.substring(email.indexOf('@') + 1, email.indexOf('.'));
                String setFrom = "devksk7@naver.com";//발신자 이메일
                String tomail = memberDTO.getEmail();
                String title = "WorkMotion 비밀번호 변경 이메일입니다";
                sb.append(String.format("안녕하세요 %s님\n", memberDTO.getName()));
                sb.append(String.format("WorkMotion 비밀번호: 임시 비밀 번호는 abcd%d입니다.", num));
                String content = sb.toString();
                MimeMessage msg = mailSenderNaver.createMimeMessage();
                MimeMessageHelper msgHelper = new MimeMessageHelper(msg, true, "utf-8");
                msgHelper.setFrom(setFrom);
                msgHelper.setTo(tomail);
                msgHelper.setSubject(title);
                msgHelper.setText(content);
                // 메일 전송
                mailSenderNaver.send(msg);
                result = 2;
                String sum = "abcd" + num;
                String hashpassword = BCrypt.hashpw(sum, BCrypt.gensalt());  //임시 비밀번호 저장
                m.setPassword(hashpassword);
                memberService.updateMember(m);
                return result;
            } else {//존재하지 않는 이메일인 경우 -> 가입되지 않은 사용자
                return result = 1;
            }
        } else {        // 파라미터가 들어오지 않을 경우
            result = 0;
            return result;
        }
    }


    @PostMapping("findId")
    @ResponseBody
    public String findId(MemberDTO memberDTO) throws Exception {
        String msg = "";
        if (memberDTO != null) {
            memberDTO = memberService.findId(memberDTO);
            if (memberDTO != null) {
                msg = memberDTO.getEmail();
            }
        }
        return msg;
    }

    @ResponseBody
    @PostMapping("pwCheck")
    public int pwCheck(HttpSession session, String pass, MemberDTO memberDTO) throws Exception {
        MemberDTO m = (MemberDTO) session.getAttribute("member");
        m = memberService.getlogin(m);
        StringTokenizer tokenizer = new StringTokenizer(pass, ",");
        memberDTO.setPassword(tokenizer.nextToken());
        int result = 0;
        if (BCrypt.checkpw(memberDTO.getPassword(), m.getPassword())) {
            result = 1;
        }
        return result;
    }

    @ResponseBody
    @GetMapping("emailcheck")
    public int getemailcheck(MemberDTO memberDTO, Model model) throws Exception {
        int result = 0;
        memberDTO = memberService.emailCheck(memberDTO);
        if (memberDTO == null) {
            result = 1;
        }
        return result;
    }

    @GetMapping("agree")
    public void getagree() throws Exception {
    }

    @GetMapping("logout")
    public String getlogout(HttpSession session) throws Exception {
        session.invalidate();
        return "/member/login";
    }

    @GetMapping("login")
    public void getlogin() throws Exception {
    }

    @PostMapping("login")
    public String getlogin(MemberDTO memberDTO, HttpSession session, Model model) throws Exception {
        MemberDTO m = memberService.getlogin(memberDTO);
        if (m != null) {
            if (BCrypt.checkpw(memberDTO.getPassword(), m.getPassword())) {
                m.setPassword(null);
                session.setAttribute("member", m);
                TossPaymentDTO tossPaymentDTO = new TossPaymentDTO();
                tossPaymentDTO.setCompany_id(m.getCompany_id());
                tossPaymentDTO = tossPaymentService.getTossPaymentDetail(tossPaymentDTO);
                if (tossPaymentDTO != null) {
                    String tossdate = tossPaymentDTO.getCreate_dt();
                    String[] ar = tossdate.split(" ");
                    String[] setDate = ar[0].split("-");
                    String[] setDate1 = ar[1].split(":");
                    LocalDateTime startDt = LocalDateTime.now();
                    LocalDateTime lastDt = LocalDateTime.of(Integer.parseInt(setDate[0]), Integer.parseInt(setDate[1]), Integer.parseInt(setDate[2]), Integer.parseInt(setDate1[0]), Integer.parseInt(setDate1[1]));
                    lastDt = lastDt.plusDays(tossPaymentDTO.getPeriod());
                    Long getdate = ChronoUnit.MILLIS.between(startDt, lastDt);
                    session.setAttribute("toss", tossPaymentDTO.getPeriod());
                    if (tossPaymentDTO != null || getdate > 0) {
                        session.setAttribute("check", "yes");
                        session.setAttribute("toss", tossPaymentDTO.getPeriod());
                    }

                }
                model.addAttribute("path", "/projects/list");
                return "commons/result";
            } else {
                // 비번이 다른경우
                model.addAttribute("msg", "비밀번호를 확인해주세요");
                return "member/login";
            }
        } else {
            // 아이디가 다른경우
            model.addAttribute("msg", "아이디를 확인해주세요");
            return "member/login";
        }

    }

    @GetMapping("join")
    public String getjoin(Model model) throws Exception {
        model.addAttribute("page", "member/join");
        return "member/join";
    }

    @GetMapping("mypage")
    public String mypage(HttpSession session, Model model) throws Exception {
        MemberDTO m = (MemberDTO) session.getAttribute("member");
        if (m == null) {
            model.addAttribute("path", "/projects/list");
            return "commons/result";
        } else {
            MemberDTO memberDTO = memberService.detailMember(m);
            model.addAttribute("dto", memberDTO);
            model.addAttribute("page", "member/mypage");
        }
        return "index";
    }

    @PostMapping("update")
    public String getupdate(MemberDTO memberDTO, Model model, MultipartFile picture) throws Exception {
        System.out.println(picture + memberDTO.getPassword());
        if (!picture.isEmpty()) {
            memberService.setFileDelete(memberDTO);
            memberService.setFileAdd(memberDTO, picture);
        }
        if (memberDTO.getPassword() != null && !memberDTO.getPassword().isEmpty()) {
            String hashpassword = BCrypt.hashpw(memberDTO.getPassword(), BCrypt.gensalt());
            memberDTO.setPassword(hashpassword);
        }
        int result = memberService.updateMember(memberDTO);
        model.addAttribute("path", "/projects/list");
        return "commons/result";
    }


    @PostMapping("join")
    public String getjoin(MemberDTO memberDTO, Model model) throws Exception {
        String hashpassword = BCrypt.hashpw(memberDTO.getPassword(), BCrypt.gensalt());//비밀번호 암호화
        memberDTO.setPassword(hashpassword);
        String[] ar = memberDTO.getEmail().split("@");    //이메일 파싱
        String sum = ar[1];
        StringTokenizer br = new StringTokenizer(sum, ".");
        CompanyDTO companyDTO = new CompanyDTO();
        companyDTO.setInfo(br.nextToken());
        CompanyDTO cdto = memberService.companyIdFind(companyDTO); //그룹명으로 회사 아이디 검색
        int result = 0;
        if (cdto != null) {                                        //회사가 있는지 없는지
            memberDTO.setCompany_id(cdto.getId());
            List<MemberDTO> cr = memberService.getCompanyMember(memberDTO);
            if (cr != null) {                                            // 사원계급
                memberDTO.setRole_id(10L);
                result = memberService.getjoin(memberDTO);
                memberService.setFileAdd(memberDTO);
            } else {                                                        //OWNER 계급
                memberDTO.setRole_id(40L);
                memberDTO.setCompany_id(cdto.getId());
                result = memberService.getjoin(memberDTO);
                memberService.setFileAdd(memberDTO);
            }
        }


        String msg = "회원 가입 실패";
        if (result > 0) {
            msg = "회원 가입 성공";
        }
        model.addAttribute("msg", msg);
        model.addAttribute("path", "/member/login");
        return "commons/result";
    }


}
