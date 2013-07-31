package com.ai.rlbootstrap.view {
	
	import com.bit101.components.HBox;
	import com.bit101.components.Label;
	import com.bit101.components.List;
	import com.bit101.components.PushButton;
	import com.bit101.components.Text;
	import com.bit101.components.VBox;
	
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	
	public class MainView extends Sprite {
		
		public const LIST_CHANGE:String = "LIST_CHANGE";
		
		public const RED:uint = 0xFF0000;
		public const YELLOW:uint = 0xFFFF00;
		public const BLUE:uint = 0x0000FF;
		public const DEFAULT:uint = 0xFFFFFF;
		
		private var _stageLayout:HBox;
		private var _detailsLayout:VBox;
		private var _picAndDescriptionLayout:HBox;
		private var _descAndButtonsLayout:VBox;
		private var _buttonsLayout:HBox;
		private var _dataList:List;
		private var _label:Label;
		private var _desc:Text;
		
		private var _changeColour:PushButton;
		private var _reset:PushButton;
		
		private var _img:Sprite;
		
		private var _lastFocus:InteractiveObject;
		
		// To remember the last button action and apply it when list selection changes
		private var _lastButton:String;
		
		public function MainView(){
			
		}
		
		public function init():void {			
			_stageLayout = new HBox(this);
			
			_dataList = new List(_stageLayout);
			_dataList.setSize(stage.stageWidth / 3, stage.stageHeight);
			_dataList.addEventListener(Event.SELECT, changeSelection);
			
			stage.addEventListener(KeyboardEvent.KEY_UP, handleListNavigation);
			stage.addEventListener(MouseEvent.CLICK, handleFocus);
			
			_detailsLayout = new VBox(_stageLayout);
			
			_label = new Label(_detailsLayout);
			
			_picAndDescriptionLayout = new HBox(_detailsLayout);
			
			_img = new Sprite();
			_img.mouseEnabled = false;
			_img.graphics.beginFill(0xFFFFFF);
			_img.graphics.drawRect(0, 0, 160, 120);
			_img.graphics.endFill();
			_picAndDescriptionLayout.addChild(_img);
			
			_descAndButtonsLayout = new VBox(_picAndDescriptionLayout);
			
			_desc = new Text(_descAndButtonsLayout);
			_desc.editable = false;
			_desc.selectable = false;
			_desc.mouseEnabled = false;
			_desc.setSize(stage.stageWidth - 50 - stage.stageWidth / 2, stage.stageHeight / 2);
			
			_buttonsLayout = new HBox(_descAndButtonsLayout);
			
			_changeColour = new PushButton(_buttonsLayout);
			_changeColour.label = "CHANGE COLOUR";
			_changeColour.addEventListener(MouseEvent.CLICK, changeColour);
			
			_reset = new PushButton(_buttonsLayout);
			_reset.label = "RESET";
			_reset.addEventListener(MouseEvent.CLICK, reset);
		}
		
		private function changeColour(event:MouseEvent = null):void {
			var red:Boolean = ((selectedIndex + 1) % 3 == 0);
			var yellow:Boolean = ((selectedIndex + 1) % 5 == 0);
			var blue:Boolean = red && yellow;
			
			if(blue) {
				stage.color = BLUE;
			}
			else if(red) {
				stage.color = RED;
			}
			else if(yellow) {
				stage.color = YELLOW;
			}
			else {
				stage.color = DEFAULT;
			}
			stage.focus = _changeColour;
			_lastFocus = stage.focus;
			_lastButton = "CHANGE";
		}
		
		private function reset(event:MouseEvent):void {
			stage.color = DEFAULT;
			stage.focus = _reset;
			_lastFocus = stage.focus;
			_lastButton = "RESET";
		}
		
		private function changeSelection(event:Event):void {
			_label.text = event.currentTarget.selectedItem;
			dispatchEvent(new Event(LIST_CHANGE));
			
			if(_lastButton == "CHANGE") changeColour();
			
			stage.focus = _dataList;
			_lastFocus = stage.focus;
		}
		
		private function handleListNavigation(event:KeyboardEvent):void {
			switch(event.keyCode) {
				case Keyboard.UP:
					if(selectedIndex > 0) selectedIndex = selectedIndex - 1;
					break;
				
				case Keyboard.DOWN:
					if(selectedIndex < _dataList.items.length) selectedIndex = selectedIndex + 1;
					break;				
			}
		}
		
		private function handleFocus(event:MouseEvent):void	{
			if(stage.focus == null)	stage.focus = _lastFocus;			
		}
		
		public function setData(list:Array):void {
			_dataList.items = list;
			selectedIndex = 0;
			stage.focus = _dataList;
			_lastFocus = stage.focus;
		}
		
		public function set selectedIndex(val:int):void {
			_dataList.selectedIndex = val;
		}
		
		public function get selectedIndex():int {
			return _dataList.selectedIndex;
		}
		
		public function set desc(val:String):void {
			_desc.text = val;
		}
		
		public function setImage(val:DisplayObject):void {
			_img.addChild(val);
		}
	}
}