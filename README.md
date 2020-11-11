# Mobile/Cloud Image Analytics PoC
머신러닝 모델 성능 개선 및 고객 셀프 서비스 확대를 위한 모바일/클라우드 이미지 분석 기술 확보

(모바일 자동차 번호판 인식 서비스 설계 및 개발 PoC)

## 배경 및 목적

現 이미지 분석 머신러닝 모델은 고객이 사진을 찍은 後 이미지시스템에 저장된 사진 이미지 파일의
사후 분석을 수행하므로, 이미지 데이터의 품질이 낮을 경우 인식률 低下

모바일/클라우드 자동차 번호판 인식 PoC 설계/개발을 통해 이미지 분석 모델 서비스의 성능 향상 및 휴대폰 카메라 기반 셀프 서비스 비즈니스의 추진 기반을 마련하고자 함


## PoC 개발 결과 : Microsoft Azure API, Google Cloud Platform API

![Demo Animated Gif](https://github.com/jiyu-dady/mobile_cloud_image_analytics/blob/master/assets/images/MobileCloudImageAnalyticsPoC_DEMO_Azure_GCP.gif)

## 프로젝트 구조

    mobile_cloud_image_analytics/
      ├ android/                               [자동생성] 안드로이드 저장소
      ├ assets/                                프로젝트에서 사용하는 asset 저장소
      │   ├ fonts/                             텍스트 폰트 저장소
      │   ├ images/                            이미지 저장소
      │   ├ launcher/                          앱 아이콘 이미지 저장소
      │   └ tessdata/                          tesseract-ocr trainned data
      ├ build/                                 [자동생성] buid 산출물 저장소 (apk 등)
      ├ ios/                                   [자동생성] iOS 저장소
      └lib/                                    [자동생성] dart 소스코드 root
        ├ common/                              공통 코드 저장
        │   ├ car_plate_number_check.dart      텍스트에서 한국 자동차 번호판 문자열 추출 Regular Expression
        │   └ theme.dart                       어플리케이션 theme (UX 스타일)
        ├ data/                                프로젝트 데이터 모델 저장
        │   ├ azure_ocr_json_parser.dart       Microsoft Azure Read API의 response JSON 응답 parser
        │   ├ demo_data.dart                   데모 화면에서 공통으로 사용하는 데이터
        │   └ google_ocr_json_parser.dart      Google Cloud Platform Vision API의 JSON 응답 parser
        ├ ocr_models/                          OCR 모델 저장소
        │   ├ google_cloud_vision.dart         Mobile/Cloud Model using Google Cloud Platform Vision API
        │   ├ google_mlkit_vision.dart         Mobile-Only Model using Google ML-Kit
        │   ├ google_tesseract.dart            Mobile/Cloud Model using Google Tesseract-OCR
        │   ├ microsoft_azure_vision.dart      Mobile/Cloud Model using Microsoft Azure Vision Read-API
        │   ├ sfmi_da_ocr_tensorflow.dart      Mobile/Cloud Model using Data Analytics Part Model
        │   └ sfmi_da_ocr_tensorflowlite.dart  Mobile-Only Model using Data Analytics Part Model
        ├ pages/                               Flutter 페이지 (모바일 화면) 저장소
        │   ├ demo_camera_control.dart         ④ '번호판 촬영' 페이지
        │   ├ demo_result.dart                 ⑤ '번호판 인식 결과' 페이지
        │   ├ demo_start.dart                  ③ '이미지 분석 기술 선택' 페이지
        │   └ login.dart                       ② '로그인' 페이지
        ├ security/                            상용 REST API 연동 키 저장소
        │   └ api_keys.dart                    Microsoft Azure, Google Cloud API 키 저장
        └ main.dart                            ① 앱 시작

### ※ 주의 사항
 - security 디렉토리 및 api_keys.dart는 배포하지 않습니다. 직접 생성하여 사용하시면 동작합니다.
 - api_keys.dart 는 다음과 같이 작성하세요.
    // Microsoft Azure Cognitive Services API Key
    final String AZURE_API_KEY = '여기에 Ocp-Apim-Subscription-Key를 넣으세요';

    // Google Cloud Platform API Key
    final String GCP_API_KEY = '여기에 GCP API Key를 넣으세요';