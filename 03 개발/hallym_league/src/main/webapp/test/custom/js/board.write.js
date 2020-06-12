
if(!window.App) {
	App = {};
}
if(!App.board){
	App.board = {};
}



/**
 * 모듈 초기화
 */
$(function() {
	
	var boardWrite = new App.board.Write();
	boardWrite.init();
	
});

/**
 * 어드민의 게시물의 전체 선택/해지 기능
 */
App.board.Write = function() {

	var self;

	return {

		init: function() {

			self = this;
			
			self.popBoardList();

		},
		
		popBoardList : function(){
			$('#copy').click(function(){
				jwxe_popupWindow( '/_custom/' + clientId + '/_common/boardList/app.do?boardTy=' + boardTy + '&boardNo=' + boardNo + '&siteId=' + siteId, "1200", "800", true, true);
			});
		}
	
	}
};


