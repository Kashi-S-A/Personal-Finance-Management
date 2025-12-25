<%@include file="head.jsp" %>

<%
	java.util.List<com.ksa.pfm.model.Category> categories=(java.util.List<com.ksa.pfm.model.Category>) request.getAttribute("categories");
%>
  <div style="margin-top:30px;display:flex;align-item:center;justify-content:center">
	<div class="glass-card">
	    <div class="brand">Add Transaction</div>
	    <div class="lead">Add a new transaction to track your spending</div>
		<p style="color: green">${param.msg}</p>
	    <form action="/add-transaction" method="post">
	      <div class="mb-3">
	        <label class="form-label" for="amount">Amount</label>
	        <input id="amount" name="amount" type="number" step="0.01" class="form-control" placeholder="Enter amount" required>
	      </div>

	      <div class="mb-3">
	        <label class="form-label" for="description">Description</label>
	        <input id="description" name="description" type="text" class="form-control" placeholder="e.g. Groceries" required>
	      </div>

	      <div class="mb-3">
	        <label class="form-label" for="date">Date</label>
	        <input id="date" name="date" type="date" class="form-control" required>
	      </div>

	      <div class="d-flex row-gap mb-3">
	       

	        <div style="flex:1">
	          <label class="form-label" for="category">Category</label>
	          <select id="category" name="category" class="form-select" required>
	            <option value="">Select category</option>
	          			<%	
	                    	if(categories!=null && !categories.isEmpty())
	                    	{
	                    	for(com.ksa.pfm.model.Category category : categories){
	                    %>
	                    	 <option value=<%=category.getName() %> ><%=category.getName() %></option>
	                    <%
	                    	}
	                    	}
	                    %>
	          </select>
	        </div>
	      </div>

	     <button type="submit" class="btn-primary-custom mt-3">Save Transaction</button>
	    </form>
	  </div>
  </div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
