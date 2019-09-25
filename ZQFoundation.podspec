#
# Be sure to run `pod lib lint ZQFoundation.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ZQFoundation'
  s.version          = '0.1.1'
  s.summary          = 'basic or common components.'
  
  s.description      = 'zq common  module description'
  s.homepage         = 'https://github.com/kelvin943/ZQFoundation'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Macro Zhang' => 'quan943@163.com' }
  s.source           = { :git => 'git@github.com:kelvin943/ZQFoundation.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'
  s.requires_arc = true

  # s.default_subspec = 'Common', 'PAStatsAOP'hareCode
  
  # 基本分类 宏定义
  s.subspec 'ZQCommon' do |ss|
      ss.source_files = 'ZQCommon/*.h'
      ss.subspec 'Category' do |si|
          si.source_files ='ZQCommon/Category/**/*.{h,m}'
      end
      ss.subspec 'Macro' do |macro|
        macro.source_files ='ZQCommon/Macro/**/*.{h,m}'
      end
  end
  
  s.subspec 'ZQUIKit' do |ss|
      ss.source_files = 'ZQUIKit/*.h'
      ss.subspec 'Category' do |category|
        category.source_files ='ZQUIKit/Category/**/*.{h,m}'
      end
      ss.subspec 'ZQCustomizeBar' do |navbar|
        navbar.source_files ='ZQUIKit/ZQCustomizeBar/**/*.{h,m}'
      end
      ss.subspec 'ZQBaseTabBarVC' do |baseTabBar|
        baseTabBar.source_files = 'ZQUIKit/ZQBaseTabBarVC/**/*.{h,m}'
      end
      ss.subspec 'ZQBaseModel' do |baseModel|
         baseModel.source_files = 'ZQUIKit/ZQBaseModel/**/*.{h,m}'
         baseModel.dependency 'YYModel','1.0.4'
      end
      ss.subspec 'ZQBaseViewModel' do |baseViewModel|
         baseViewModel.source_files = 'ZQUIKit/ZQBaseViewModel/**/*.{h,m}'
      end
      ss.subspec 'ZQBaseVC' do |baseVC|
         baseVC.source_files = 'ZQUIKit/ZQBaseVC/**/*.{h,m}'
      end
      ss.subspec 'ZQTableView' do |baseTableview|
         baseTableview.source_files = 'ZQUIKit/ZQTableView/**/*.{h,m}'
         baseTableview.dependency 'ZQFoundation/ZQUIKit/ZQBaseVC'
         baseTableview.dependency 'ZQFoundation/ZQUIKit/ZQBaseModel'
         baseTableview.dependency 'MJRefresh',  '3.2.0'
      end
  end
  
end
