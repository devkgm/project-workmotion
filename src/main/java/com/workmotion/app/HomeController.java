package com.workmotion.app;

import com.workmotion.app.member.MemberDTO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpSession;
import java.util.Locale;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {


    private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

    /**
     * Simply selects the home view to render by returning its name.
     */
    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String home(Locale locale, Model model, HttpSession session) {
        logger.info("Welcome home! The client locale is {}.", locale);
        MemberDTO memberDTO = (MemberDTO) session.getAttribute("member");
        if (memberDTO != null) {        //로그인 된사람
            if (memberDTO.getRole_id() != 10L) {      //권한이 10이 아닌 사람
                model.addAttribute("page", "/project/index");
                return "index";
            } else {                                //권한이 10인 사람
                model.addAttribute("msg", "아직 승인이 되지 않았습니다");
                model.addAttribute("path", "/member/login");
                return "commons/result";
            }
        } else {                        //로그인이 안된 사람
            return "/member/login";
        }

    }

}
