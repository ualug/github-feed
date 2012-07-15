// Generated by CoffeeScript 1.3.3

$(function() {
  var entryModel, type2action;
  type2action = function(entry) {
    entry.action = (function() {
      switch (entry.type.replace(/Event$/, '')) {
        case "CommitComment":
          return "commented on a commit";
        case "Create":
          return "created a repo";
        case "Delete":
          return "deleted a repo";
        case "Download":
          return "downloaded something";
        case "Follow":
          return "followed someone";
        case "Fork":
          return "forked a repo";
        case "ForkApply":
          return "applied a fork";
        case "Gist":
          return "manipulated a gist";
        case "Gollum":
          return "caressed his precious";
        case "IssueComment":
          return "commented on an issue";
        case "Issues":
          return "did something with an issue";
        case "Member":
          return "did something with a team";
        case "Public":
          return "did something public";
        case "PullRequest":
          return "did something with a pull request";
        case "PullRequestReviewComment":
          return "commented on a pull request";
        case "Push":
          return "pushed to a repo";
        case "TeamAdd":
          return "joined a team";
        case "Watch":
          return "started to watch something";
      }
    })();
    return entry;
  };
  entryModel = Handlebars.compile($("#entry-model").html());
  $.get("/proxy/feed.json", function(feed) {
    var entry, _i, _len;
    for (_i = 0, _len = feed.length; _i < _len; _i++) {
      entry = feed[_i];
      entry = type2action(entry);
      $("#feed").prepend(entryModel(entry));
    }
    $("time").timeago();
    $("time").each(function(i, t) {
      return $(t).attr("title", $(t).attr("datetime"));
    });
  });
});
