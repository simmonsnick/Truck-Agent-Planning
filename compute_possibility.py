import sys
import copy
import random
from collections import defaultdict

# ==== Plan File Input ====
plan_file = sys.argv[1] if len(sys.argv) > 1 else "sas_plan"

try:
    with open(plan_file, "r") as f:
        lines = f.readlines()
except FileNotFoundError:
    print(f"Error: Cannot open plan file: {plan_file}")
    sys.exit(1)

# === Count the number of real plan actions ===
num_actions = sum(
    1 for line in lines
    if line.strip() and not line.strip().startswith(";")
)


# === Possibility Score (Lower actions = higher score) ===
score = round(1.0 / (1 + num_actions), 3)
print("Possibility Degree:", score)


# === Base Segment Probabilities ===
base_segments = [
    ['M1', 'M2', 0.5, 0.5, 0.1, 0.1, 0.1, 0.1, 0.5],
    ['M1', 'M3', 0.9, 0.9, 0.9, 0.9, 0.9, 0.9, 1.0],
    ['M2', 'M3', 0.7, 0.7, 0.6, 0.6, 0.5, 0.5, 0.8],
    ['M2', 'M4', 0.5, 0.5, 0.1, 0.1, 0.1, 0.1, 0.5],
    ['M3', 'M4', 0.9, 0.9, 0.9, 0.9, 0.9, 0.9, 1.0],
    ['M3', 'M5', 0.5, 0.5, 0.1, 0.1, 0.1, 0.1, 0.5],
    ['M4', 'M5', 0.9, 0.9, 0.9, 0.9, 0.9, 0.9, 1.0],
    ['M5', 'M6', 0.5, 0.5, 0.1, 0.1, 0.1, 0.1, 0.5],
    ['M6', 'M7', 0.9, 0.9, 0.9, 0.9, 0.9, 0.9, 1.0],
]

# === Calculate segment possibility score ===
def calculate_possibility(probabilities):
    return min(
        probabilities[0],
        probabilities[1],
        1 - probabilities[2],
        1 - probabilities[3],
        1 - probabilities[4],
        1 - probabilities[5]
    )

# === Find all paths between two nodes ===
def map_paths(graph, current, end, path=None):
    if path is None:
        path = []
    path = path + [current]
    if current == end:
        return [path]
    paths = []
    for node in graph[current]:
        if node not in path:
            new_paths = map_paths(graph, node, end, path)
            paths.extend(new_paths)
    return paths

# === Get path score ===
def calculate_path_possibility(path, possibilities):
    try:
        return min(possibilities[(path[i], path[i + 1])] for i in range(len(path) - 1))
    except KeyError:
        return None

# === Generate best path per agent ===
def compute_agent_paths(agents, base_segments):
    agent_paths = {}
    for agent_index, (agent, info) in enumerate(agents.items()):
        # Deep copy  per agent
        custom_segments = copy.deepcopy(base_segments)
        for seg in custom_segments:
            for i in range(2, len(seg)):
                delta = random.uniform(-0.05, 0.05)
                seg[i] = max(0.0, min(1.0, seg[i] + delta))

        # Build agent graph
        graph = defaultdict(list)
        for start, end, *_ in custom_segments:
            graph[start].append(end)

        # Build possibility map for this agent
        possibilities = {
            (row[0], row[1]): calculate_possibility(row[2:])
            for row in custom_segments
        }

        # Get all valid paths and their scores
        all_paths = map_paths(graph, info['start'], info['goal'])
        path_scores = {
            tuple(p): calculate_path_possibility(p, possibilities)
            for p in all_paths
            if calculate_path_possibility(p, possibilities) is not None
        }

        if path_scores:
            best_path = max(path_scores, key=path_scores.get)
            agent_paths[agent] = {
                'path': best_path,
                'possibility': round(path_scores[best_path], 3)
            }
        else:
            agent_paths[agent] = {'path': None, 'possibility': None}

    return agent_paths

# === Output Results ===
def print_agent_paths(agent_paths):
    print("\n--- Agent Simulations ---")
    for agent, result in agent_paths.items():
        if result['path']:
            path_str = '-'.join(result['path'])
            print(f"{agent}: Best path is {path_str} with possibility {result['possibility']}")
        else:
            print(f"{agent}: No valid path found.")

def truck_plan_path(plan_lines):
    path = []
    for line in plan_lines:
        line_lower = line.lower()
        if "drive" in line_lower and "truck" in line_lower:
            parts = line.strip("()\n").split()
            if len(parts) >= 4:
                from_loc = parts[2].upper()
                to_loc = parts[3].upper()
                if not path:
                    path.append(from_loc)
                path.append(to_loc)
    return path

# === Main Function ===
def main():
    agents = {
        'Agent1': {'start': 'M1', 'goal': 'M7'},
        'Agent2': {'start': 'M1', 'goal': 'M7'},
        'Agent3': {'start': 'M1', 'goal': 'M7'}
        #'Agent4': {'start': 'M1', 'goal': 'M7'},
        #'Agent5': {'start': 'M1', 'goal': 'M7'}
    }

    agent_paths = compute_agent_paths(agents, base_segments)
    print_agent_paths(agent_paths)

    # === Actual Plan Analysis ===
    try:
        with open(plan_file, "r") as f:
            plan_lines = f.readlines()
    except FileNotFoundError:
        print(f"\nError: Cannot open plan file: {plan_file}")
        return

    actual_path = truck_plan_path(plan_lines)

    if actual_path:
        # Build possibility map
        base_possibility = {
            (row[0], row[1]): calculate_possibility(row[2:])
            for row in base_segments
        }
        actual_poss = calculate_path_possibility(actual_path, base_possibility)
        real_path_str = '-'.join(actual_path)
        print(f"\nActual Plan Path: {real_path_str}")
        #print(f"Actual Path Possibility: {round(actual_poss, 3)}")
    else:
        print("\nNo drive-truck actions found in plan.")


if __name__ == "__main__":
    main()
