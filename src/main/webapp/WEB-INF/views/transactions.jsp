<%@include file="head.jsp" %>

<%
    java.util.List<com.ksa.pfm.model.Category> categories =
        (java.util.List<com.ksa.pfm.model.Category>) request.getAttribute("categories");

    java.util.List<com.ksa.pfm.model.Transaction> txns =
        (java.util.List<com.ksa.pfm.model.Transaction>) request.getAttribute("txns");

    com.ksa.pfm.model.TransactionType selectedType =
        (com.ksa.pfm.model.TransactionType) request.getAttribute("selectedType");

    java.lang.Long selectedCategory =
        (java.lang.Long) request.getAttribute("selectedCategory");

    java.lang.String selectedFromDate =
        request.getAttribute("selectedFromDate") == null
        ? ""
        : request.getAttribute("selectedFromDate").toString();

    java.lang.String selectedToDate =
        request.getAttribute("selectedToDate") == null
        ? ""
        : request.getAttribute("selectedToDate").toString();
%>

<div class="card-container">

    <div class="layout-container">

        <!-- FILTER SIDEBAR -->
        <form action="/filter-transactions" method="post" class="filter-sidebar">

            <h5>Filters</h5>

            <!-- TYPE -->
            <label class="form-label" for="type">Type</label>
            <select id="type" name="type" class="form-select">
                <option value="">Select type</option>
                <option value="INCOME"
                    <%= (selectedType != null && selectedType.name().equals("INCOME"))
                        ? "selected" : "" %>>
                    INCOME
                </option>
                <option value="EXPENSE"
                    <%= (selectedType != null && selectedType.name().equals("EXPENSE"))
                        ? "selected" : "" %>>
                    EXPENSE
                </option>
            </select>

            <!-- CATEGORY -->
            <label class="form-label mt-2" for="category">Category</label>
            <select id="category" name="category" class="form-select">
                <option value="">Select category</option>

                <%
                    if (categories != null && !categories.isEmpty()) {
                        for (com.ksa.pfm.model.Category category : categories) {
                %>
                    <option value="<%=category.getId()%>"
                        <%= (selectedCategory != null &&
                             selectedCategory.equals(category.getId()))
                            ? "selected" : "" %>>
                        <%=category.getName()%>
                    </option>
                <%
                        }
                    }
                %>
            </select>

            <!-- FROM DATE -->
            <label class="form-label mt-2">From Date</label>
            <input type="date"
                   name="fromDate"
                   class="form-control"
                   value="<%= selectedFromDate %>">

            <!-- TO DATE -->
            <label class="form-label mt-2">To Date</label>
            <input type="date"
                   name="toDate"
                   class="form-control"
                   value="<%= selectedToDate %>">

            <!-- APPLY -->
            <button type="submit" class="btn-primary-custom mt-3 w-100">
                Apply Filters
            </button>

        </form>

        <!-- MAIN CONTENT -->
        <div class="main-content">

            <div class="page-title">Your Transactions</div>

            <div class="table-responsive">
                <table class="table table-hover align-middle">
                    <thead>
                        <tr>
                            <th>Date</th>
                            <th>Description</th>
                            <th>Category</th>
                            <th>Type</th>
                            <th>Amount</th>
                            <th style="width:150px;">Action</th>
                        </tr>
                    </thead>
                    <tbody>

                        <%
                            if (txns != null && !txns.isEmpty()) {
                                for (com.ksa.pfm.model.Transaction txn : txns) {
                        %>
                        <tr>
                            <td><%= txn.getDate() %></td>
                            <td><%= txn.getDescription() %></td>
                            <td><%= txn.getCategory().getName() %></td>
                            <td><%= txn.getType() %></td>
                            <td><%= txn.getAmount() %></td>
                            <td>
                                <form action="/edit/<%= txn.getId() %>" method="get" style="display:inline;">
                                    <button type="submit" class="btn-edit">Edit</button>
                                </form>
                                <form action="/delete/<%= txn.getId() %>" method="get" style="display:inline;">
                                    <button type="submit" class="btn-delete">Delete</button>
                                </form>
                            </td>
                        </tr>
                        <%
                                }
                            } else {
                        %>
                        <tr>
                            <td colspan="6" class="text-center text-danger">
                                No Transactions Found
                            </td>
                        </tr>
                        <%
                            }
                        %>

                    </tbody>
                </table>
            </div>

        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
