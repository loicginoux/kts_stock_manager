class KTS.RadioBoxController extends Spine.Controller
	events:
		"click .btn" : "switchOption"
	elements:
		".btn-group" : "btnGroup"
		".btn-group .btn" : "buttons"


	constructor: ()->
		super
		@input.val("student") unless @input.val()
		id =  @input.val()
		@btnGroup.find("[data-id='"+id+"']").addClass "active"

	switchOption:	(e) ->
		id = $(e.target).attr("data-id")
		@input.val(id)
		$(".control-group").not(".role").addClass("hide")
		$("."+id).removeClass("hide")
