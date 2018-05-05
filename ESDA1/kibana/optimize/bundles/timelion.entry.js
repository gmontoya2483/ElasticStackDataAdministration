
/**
 * Test entry file
 *
 * This is programatically created and updated, do not modify
 *
 * context: {"env":"production","urlBasePath":"","kbnVersion":"6.0.0-rc1","buildNum":15976}
 * includes code from:
 *  - console@kibana
 *  - elasticsearch@kibana
 *  - kbn_doc_views@kibana
 *  - kbn_vislib_vis_types@kibana
 *  - kibana@kibana
 *  - markdown_vis@kibana
 *  - metrics@kibana
 *  - region_map@kibana
 *  - spy_modes@kibana
 *  - state_session_storage_redirect@kibana
 *  - status_page@kibana
 *  - table_vis@kibana
 *  - tagcloud@kibana
 *  - tile_map@kibana
 *  - timelion@kibana
 *
 */

require('ui/chrome');
require('plugins/timelion/app_with_autoload');
require('plugins/kibana/visualize/saved_visualizations/saved_visualization_register');
require('plugins/kibana/discover/saved_searches/saved_search_register');
require('plugins/kibana/dashboard/saved_dashboard/saved_dashboard_register');
require('plugins/console/hacks/register');
require('plugins/kibana/dev_tools/hacks/hide_empty_tools');
require('plugins/timelion/lib/panel_registry');
require('plugins/timelion/panels/timechart/timechart');
require('ui/chrome').bootstrap(/* xoxo */);

