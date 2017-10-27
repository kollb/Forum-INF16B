<%@ page import = "de.dhbw.StudentForum.Posting, de.dhbw.StudentForum.DAO, de.dhbw.StudentForum.User" %>

<%
    // @author Bernhard Koll, Jan Malchert
    // Service to create a new posting

    int subjectid = 0;
    String replystring = request.getParameter("replystring");
    User loggedUser = (User) session.getAttribute("user");

    if (loggedUser == null){
        out.println("{status:\"Error\", message:\"User nicht eingeloggt.\"}");
        return;
    }

    try {
        subjectid = Integer.parseInt(request.getParameter("subjectid"));
    }
    catch(Exception e) {}

    DAO daoObject = new DAO();

    if(subjectid <= 0 || replystring == null || replystring.length() == 0)
    {
        out.println("{status:\"Error\", message:\"F&uuml;llen Sie alle Informationen aus.\"}");
    }
    else
    {
        Posting newPosting = new Posting(0);
        newPosting.setMessage(replystring);
        newPosting.setSubjectId(subjectid);
        newPosting.setUserId(loggedUser.getId());

        int newPostingId = daoObject.addNewPosting(posting);
        if(newPostingId > 0) {
            out.println("{\"status\": \"Ok\", \"postingid\": " + newPostingId + "}");
        } else {
            out.println("{status:\"Error\", message:\"Interner Fehler.\"}");
        }    }
%>
