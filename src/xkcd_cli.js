// terminal.print($('<iframe width="800" height="600" src="http://www.robotfindskitten.net/rfk.swf"></iframe>'));
// terminal.print('sudo: '+cmd_name+': command not found');
// terminal.print($('<a>').text('*** FREE SHIPPING ENABLED ***').attr('href', 'http://store.xkcd.com/'));
// return $('#screen').fadeOut();

// terminal.setWorking(true);
// terminal.print($('<p>').addClass('error').text('display: unable to open image "'+path+'": No such file or directory.'));
// terminal.setWorking(false);

TerminalShell.filters.push(function (terminal, cmd) {
	if (/!!/.test(cmd)) {
		var newCommand = cmd.replace('!!', this.lastCommand);
		terminal.print(newCommand);
		return newCommand;
	} else {
		return cmd;
	}
});


TerminalShell.commands['welcome'] = function(terminal, a, b) {
	terminal.print('Type help  if you\'re lost');
}; 

// No peeking!
TerminalShell.commands['help'] = TerminalShell.commands['halp'] = function(terminal, a, b) {
	terminal.print('That would be cheating!', a, b);
}; 


// our interface doesn't conform to normal cli syntax. register a fallback to 
// catch and parse the command
TerminalShell.fallback = function (terminal, cmd) {
	cmd = cmd.toLowerCase().trim();
	
	// parse the string into a desciptor
	result = tokenize(terminal, cmd);

	// null means tokenizer failure
	if(!result) return false;

	// must be exactly one hashtag (no commands support more than one hashtag)
	if(result.commands.length != 1) return false;

	//Terminal.print('tokens:', JSON.stringify(result.tokens));
	
	// route the command
	if ( result.commands[0] === '#is') {
		_is(result.tokens);
	} 
	else if(result.commands[0] === '#in') {
		_in(result.tokens);
	}
	else {
		// TOOD: return false if there's no command match
		return false;
	}
	return true;
};

// [ text ] #is [ all nouns ]
function _is(tokens) {
	var nouns = { 'artist': true, 'band': true, 'feeling': true,
				 'genre': true, 'song': true, 'user': true };
	// validate format
	if (tokens.length != 3 || tokens[0].type != 'text' || tokens[1].type != 'command' || tokens[2].type != 'text')
		Terminal.print($('<p>').addClass('error').text('invalid format for #is command. example: thrice #is band'));
	else if (!nouns[tokens[2].data]) {
		Terminal.print($('<p>').addClass('error').text('what is "' + tokens[2].data + '"? artist, band, feeling, genre, song, or user?'));
	}
	else {
		// TODO: handle the is command 
		Terminal.print($('<p>').addClass('success').text('OK "'+ tokens[0].data +'" is a ' + tokens[2].data));
	}
}

// [ artist ] #in [ band | genre ]
// [ band ]   #in [ genre ]
function _in(tokens) {
	// validate format
	if (tokens.length != 3 || tokens[0].type != 'text' || tokens[1].type != 'command' || tokens[2].type != 'text')
		Terminal.print($('<p>').addClass('error').text('invalid format for #is command'));
	else
		// TODO: handle the in command :)
		Terminal.print('in');
}



// tokenize the input string into a list of objects
function tokenize (terminal, cmd) {
	var args = cmd.split(' ');
	var arg = null;
	var buf = '';

	var result = { tokens: [], commands: [] };

	for (var i=0; i < args.length;i ++) {
		arg = args[i];
		if (arg) {
			if (arg.indexOf('#') === 0) {
				if (arg.length == 1) {
					return null;
				}
				else {
					if (buf.length) {
						result.tokens.push ( { type: 'text', data: buf.trim() } );
						buf = '';
					}
					result.tokens.push ( { type: 'command', data: arg } );
					result.commands.push(arg);
				}
			}
			else if(arg.indexOf('#') > 0) {
				return null;
			}
			else {
				// this must be part of a string
				buf += (arg + ' '); 
			}
		}
	}
	// if the buffer has any leftover content, it must be a text entry
	if (buf.length) {
		result.tokens.push( { type: 'text', data: buf.trim() } );
	}
	return result;
}


$(document).ready(function() {
	Terminal.promptActive = false;
	function noData() {
		Terminal.print($('<p>').addClass('error').text('Unable to load startup data. :-('));
		Terminal.promptActive = true;
	}
	$('#screen').bind('cli-load', function(e) {
		$('#screen').one('cli-ready', function(e) {
			//Terminal.print('terminal ready');
			//Terminal.runCommand('cat welcome.txt');
		});
		Terminal.runCommand('welcome');
	});
});
