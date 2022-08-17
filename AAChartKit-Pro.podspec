Pod::Spec.new do |s|
    s.name         = 'AAChartKit-Pro'
    s.version      = '0.0.3'
    s.summary      = '📈📊🎓🎓🎓AAChartKit-Pro is a professional version of AAChartKit, it is an elegant and beutiful chart framework for iOS, iPadOS, macOS. AAChartKit-Pro is a more powerful data visualization framework that supports more types beautiful chart like bellcurve, bullet, columnpyramid, cylinder, dependencywheel, heatmap, histogram, networkgraph, organization, packedbubble, pareto, sankey, series, solidgauge, streamgraph, sunburst, tilemap, timeline, treemap, variablepie, variwide, vector, venn, windbarb, wordcloud, xrange charts and so on.'
    s.homepage     = 'https://github.com/AAChartModel/AAChartKit-Pro'
    s.license      = "Just for Test Demo"
    s.authors      = {'An An' => '2236368544@qq.com'}
    s.source       = {:git => 'https://github.com/AAChartModel/AAChartKit-Pro.git', :tag => s.version}
    s.social_media_url = 'https://github.com/AAChartModel'
    s.source_files = 'AAChartKit-Pro/**/*.{h,m}'
    s.resource_bundles    = { 'AAChartKit-Pro' => 'AAChartKit-Pro/AAJSFiles.bundle' }
    s.prefix_header_contents = '#import "AAGlobalMacro.h"'
    s.requires_arc = true
    s.ios.frameworks = 'UIKit'
    s.ios.deployment_target = '9.0'
    s.osx.deployment_target = '10.11'
  end
