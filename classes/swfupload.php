<?php
/**
 * @copyright Copyright(c) 2011 jooyea.cn
 * @file swfupload.php
 * @brief swfupload上传组件
 * @author nswe
 * @date 2013/3/18 15:54:25
 */
class Swfupload
{
	public $path;

	//构造函数
	public function __construct()
	{
		$this->path = IUrl::creatUrl().'plugins/swfupload/';

echo <<< OEF
	<script type="text/javascript" src="{$this->path}swfupload.js"></script>
	<script type="text/javascript" src="{$this->path}handlers.js"></script>
OEF;
	}

	//展示插件
	public function show()
	{
		$sessionName = ISafe::name();
		$sessionId   = ISafe::id();
		$uploadUrl   = IUrl::creatUrl('/goods/goods_img_upload');
		$admin_name  = ISafe::get('admin_name');
		$admin_pwd   = ISafe::get('admin_pwd');

echo <<< OEF
		<script type="text/javascript">
		window.onload = function()
		{
			new SWFUpload({
				// Backend Settings
				upload_url: "{$uploadUrl}",
				post_params: {"{$sessionName}": "{$sessionId}","admin_name":"{$admin_name}","admin_pwd":"{$admin_pwd}"},

				// File Upload Settings
				file_types : "*.jpg;*.jpge;*.png;*.gif",

				// Event Handler Settings - these functions as defined in Handlers.js
				//  The handlers are not part of SWFUpload but are part of my website and control how
				//  my website reacts to the SWFUpload events.
				swfupload_preload_handler : preLoad,
				swfupload_load_failed_handler : loadFailed,
				file_queue_error_handler : fileQueueError,
				file_dialog_complete_handler : fileDialogComplete,
				upload_progress_handler : uploadProgress,
				upload_error_handler : uploadError,
				upload_success_handler : uploadSuccess,
				upload_complete_handler : uploadComplete,

				// Button Settings
				button_placeholder_id : "uploadButton",
				button_width: 50,
				button_height: 21,
				button_text : '选择...',
				button_window_mode: SWFUpload.WINDOW_MODE.TRANSPARENT,
				button_cursor: SWFUpload.CURSOR.HAND,

				// Flash Settings
				flash_url : "{$this->path}swfupload.swf",

				custom_settings : {
					upload_target : "divFileProgressContainer"
				},

				// Debug Settings
				debug: false
			});
		};
		</script>
OEF;
	}
}