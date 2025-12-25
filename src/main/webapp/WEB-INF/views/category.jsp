<%
	java.util.List<com.ksa.pfm.model.Category> categories=(java.util.List<com.ksa.pfm.model.Category>) request.getAttribute("categories");
%>
<%@include file="head.jsp" %>


<div class="container mt-5">

   

    <h5 class="mb-3">All Categories</h5>

    <!-- TABLE -->
    <div class="table-responsive">
        <table class="table table-bordered table-striped text-center align-middle">
            <thead class="table-dark">
                <tr>
                    <th>Name</th>
                    <th>Type</th>
                </tr>
            </thead>

            <tbody>
				<% 
				if(categories!=null && !categories.isEmpty())
				{
					for(com.ksa.pfm.model.Category category: categories)
					{
				%>
						<tr>
						    <td> <%=category.getName() %> </td>
						    <td> <%=category.getType() %> </td>
					   </tr>	
				<%			
					}
				}
				else
				{
				%>
					    <tr>
					        <td>Categories does not exists</td>
					   </tr>
				<%
				}
				%>
            </tbody>
        </table>
    </div>

</div>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>