//
//  PolicyViewModel.swift
//  Wastory
//
//  Created by mujigae on 2/1/25.
//

import SwiftUI
import Observation

@Observable final class PolicyViewModel {
    let policies: [Policy] = [
        Policy(
            title: "1. 회사가 제공하는 서비스",
            terms: [
                "서비스는 와스토리(Wastory) 서비스와 이에 부가하여 회사가 제공하는 일체의 서비스를 말합니다. 여기에는 아래의 와스토리, 팀블로그, 응원하기 등을 포함하며 이에 한정되지 않습니다."
            ]
        ),
        Policy(
            title: "1-1. 와스토리(Wastory) 서비스",
            terms: [
                "회원은 블로그를 개설하여 콘텐츠를 게시하거나, 다른 회원이 공개한 콘텐츠를 보거나 댓글을 달 수 있습니다.",
                "회원은 블로그에 기본적으로 포함된 기능 외에도 플러그인을 통해 다양한 기능을 활용할 수 있습니다.",
                "회사는 서비스 내에서 광고를 게재할 수 있으며, 게재되는 광고의 형태 및 위치, 노출 빈도, 수익의 귀속 등은 회사가 정합니다.",
                "회원이 게시물 등에 Youtube 플러그인 기능을 사용할 경우 회원은 Youtube 서비스 이용약관을 준수하여야 합니다."
            ]
        ),
        Policy(
            title: "1-2. 팀블로그 서비스",
            terms: [
                "회사의 서비스에서 제공하는 모든 블로그는 블로그를 개설한 회원의 의사에 따라 팀블로그로 운영할 수 있습니다.",
                "회원은 다른 회원이 개설한 팀블로그에 초대 메일을 통해 팀원으로 초대받을 수 있으며 초대 메일의 내용에 동의하고 승낙함으로써 팀블로그 회원으로 이용할 수 있습니다.",
                """
                팀블로그의 회원 등급은 소유자, 관리자, 편집자, 필자의 4단계의 등급으로 구분이 되며 각 권한과 책임 범위는 다음 각 목과 같습니다.
                가. 소유자(팀블로그를 만든 회원을 말합니다)는 팀블로그 운영에 대한 모든 권리를 가지게 되며, 다른 회원을 초대하여 팀블로그의 개설, 운영, 폐쇄 및 회원 관리를 할 수 있습니다. 또한 관리자(소유자가 지정한 운영 자격을 가지는 회원을 말합니다)에게 회원 관리의 권한을 부여할 수 있습니다.
                나. 관리자는 소유자가 부여한 회원 관리 권한 외에 편집자와 필자의 권한을 관리할 수 있습니다.
                다. 편집자는 필자가 팀블로그에 게시한 게시물 등에 대한 편집 권한을 가지며 회원 관리 권한은 수행할 수 없습니다.
                라. 필자는 팀블로그에 게시물 등을 게시할 수 있으며 본인이 게시한 게시물 등에 대한 편집 권한을 가집니다. 필자에 의해 올려진 게시물 등은 공개 게시물 등에 한해 팀블로그로 저작물에 대한 권한이 귀속됩니다. 필자는 회원 관리 권한은 수행할 수 없습니다.
                """,
                "팀블로그의 모든 회원은 자유롭게 팀블로그를 탈퇴할 수 있습니다. 팀블로그에 올려진 게시물 등은 팀블로그 저작물로 인정되어 회원 탈퇴 시 별도의 삭제 작업을 병행하지 않습니다.",
                "팀블로그에 올려진 게시물에 대한 모든 책임은 팀블로그 소유자에게 있습니다.",
                "휴면 등의 사유로 팀블로그 소유자의 계정이 탈퇴되는 경우 및 소유자가 자신의 권한을 정상적으로 유지하지 못할 경우 회사는 소유자 다음으로 회원 등급이 높은 회원(관리자, 편집자, 필자 순)에게 팀블로그 소유자의 지위를 자동으로 양도합니다. 이때 동일 등급의 회원이 여러 명이라면 가입 시점이 가장 빠른 회원에게 지위를 양도하며, 지위의 양도는 소유자의 계정이 탈퇴되는 즉시 이루어집니다."
            ]
        ),
        Policy(
            title: "1-3. 응원하기",
            terms: [
                "응원하기란 콘텐츠의 창작자에 대한 감사와 응원을 후원금과 메시지로 표현하는 것을 의미합니다.",
                "회사의 내부 기준에 의해 선정된 창작자가 별도의 창작자 정산센터 이용약관 동의를 하고 응원하기 관련 기능을 적용한 경우에 회원은 창작자에 대한 응원하기를 할 수 있습니다.",
                "창작자가 응원하기를 통해 받은 후원금은 창작자 정산센터에서 지급 받을 수 있으며, 후원금 지급 기준 등 후원금 관련 구체적인 사항은 창작자 정산센터 이용약관에서 정하는 바에 따릅니다.",
                "응원하기의 후원 기능은 만 14세 이상 본인 인증된 회원만 이용할 수 있습니다.",
                "응원하기는 회원의 자발적 결제이므로 청약철회가 불가능한 서비스임을 콘텐츠산업진흥법에 의거 알려 드립니다.",
                "회사는 서비스에 게재된 콘텐츠에 회원이 자발적으로 응원하기를 할 수 있는 시스템을 운영 및 관리하고 제공할 뿐이며, 회원을 대리하지 않습니다."
            ]
        ),
        Policy(
            title: "2. 이용제한 사유에 해당하는 금지활동",
            terms: [
                "회원 정보에 허위 내용을 등록하는 행위",
                "회사의 서비스에 게시된 정보를 변경하거나 서비스를 이용하여 얻은 정보를 회사의 사전 승낙 없이 영리 또는 비영리의 목적으로 복제, 출판, 방송 등에 사용하거나 제3자에게 제공하는 행위",
                "회사가 제공하는 서비스를 이용하여 제3자에게 본인을 홍보할 기회를 제공 하거나 제3자의 홍보를 대행하는 등의 방법으로 금전을 수수하거나 서비스를 이용할 권리를 양도하고 이를 대가로 금전을 수수하는 행위",
                "회사 기타 제3자의 명예를 훼손하거나 지적재산권을 침해하는 등 회사나 제3자의 권리를 침해하는 행위",
                "다른 회원의 이메일주소 및 비밀번호를 도용하여 부당하게 서비스를 이용하는 행위",
                "정크메일(junk mail), 스팸메일(spam mail), 행운의 편지(chain letters), 피라미드 조직에 가입할 것을 권유하는 메일, 외설 또는 폭력적인 메시지 ·화상·음성 등이 담긴 메일을 보내거나 기타 공서양속에 반하는 정보를 공개 또는 게시하는 행위",
                "정보통신망이용촉진및정보보호등에관한법률 등 관련 법령에 의하여 그 전송 또는 게시가 금지되는 정보(컴퓨터 프로그램 등)를 전송, 게시하거나 청소년보호법에서 규정하는 청소년 유해 매체물을 게시하는 행위",
                "공공질서 또는 미풍양속에 위배되는 내용의 정보, 문장, 도형, 음성 등을 유포하는 행위",
                "회사의 직원이나 서비스의 관리자를 가장하거나 사칭하여 또는 타인의 명의를 모용하여 글을 게시하거나 메일을 발송하는 행위",
                "컴퓨터 소프트웨어, 하드웨어, 전기통신 장비의 정상적인 가동을 방해, 파괴할 목적으로 고안된 소프트웨어 바이러스, 기타 다른 컴퓨터 코드, 파일, 프로그램을 포함하고 있는 자료를 게시하거나 전자우편으로 발송하는 행위",
                "스토킹(stalking) 등 다른 회원의 서비스 이용을 방해하는 행위",
                "다른 회원의 개인정보를 그 동의 없이 수집, 저장, 공개하는 행위",
                "불특정 다수의 회원을 대상으로 하여 광고 또는 선전을 게시하거나 스팸메일을 전송하는 등의 방법으로 회사에서 제공하는 서비스를 이용하여 영리 목적의 활동을 하는 행위",
                "회사가 제공하는 소프트웨어 등을 개작하거나 리버스 엔지니어링, 디컴파일, 디스어셈블 하는 행위",
                "회사가 제공하는 도메인 연결 기능 외에 어떤 방식으로든 다른 사이트로 주소를 강제 전환(리다이렉트)하거나 사이트 납치를 시도하는 행위",
                "서비스 내 보안에 위협이 되는 취약한 코드를 포함시키는 행위",
                "어떤 방식으로든 서비스 내에 게재된 광고를 포함한 회사가 제공하는 정보 등을 변경, 조작하거나 정상적인 노출을 방해하는 등의 행위",
                "회사가 정하지 않은 비정상적인 방법으로 결제를 하는 행위",
                "정치자금법, 청탁금지법 등의 관련 법령을 위반하거나 자금 세탁, 불법 증여 등의 위법 행위",
                "기타 현행 법령, 본 운영정책 등 회사가 제공하는 서비스 관련 약관, 운영정책, 기타 서비스 이용에 관한 규정을 위반하는 행위"
            ]
        ),
        Policy(
            title: "3. 이용제한 조치",
            terms: [
                "회사는 회원이 이용제한 사유에 해당하는 행위를 하는 경우 해당 게시물 등을 삭제 또는 임시조치할 수 있고 회원의 서비스 이용을 일시적 또는 영구적으로 제한하거나 일방적으로 본 계약을 해지할 수 있습니다.",
                "본 운영정책 2.에서 열거한 행위에 구체적으로 해당하지 않는 사항이라 하더라도 건전한 서비스 환경 제공에 악영향을 끼치는 경우는 이용이 제한될 수 있으며, 위반 활동이 반복되는 경우 가중 처리될 수 있습니다."
            ]
        )
    ]
    let indexSymbols: [Image] = [   // unicode 렌더링 이슈로 symbol 사용
        Image(systemName: "1.circle"), Image(systemName: "2.circle"),
        Image(systemName: "3.circle"), Image(systemName: "4.circle"),
        Image(systemName: "5.circle"), Image(systemName: "6.circle"),
        Image(systemName: "7.circle"), Image(systemName: "8.circle"),
        Image(systemName: "9.circle"), Image(systemName: "10.circle"),
        Image(systemName: "11.circle"), Image(systemName: "12.circle"),
        Image(systemName: "13.circle"), Image(systemName: "14.circle"),
        Image(systemName: "15.circle"), Image(systemName: "16.circle"),
        Image(systemName: "17.circle"), Image(systemName: "18.circle"),
        Image(systemName: "19.circle"), Image(systemName: "20.circle")
    ]
}
